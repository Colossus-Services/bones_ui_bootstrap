@TestOn('browser')
library;

import 'dart:js_interop_unsafe';

import 'package:bones_ui/bones_ui.dart';
import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';
import 'package:swiss_knife/swiss_knife.dart';
import 'package:test/test.dart';
import 'package:web_utils/web_utils.dart';

/// `BSDateRangePicker` without JQuery (never loaded in this test file), with
/// two pickers in the page.
void main() {
  group('BSDateRangePicker (no JQuery)', () {
    late HTMLDivElement rootContainer;
    late _Root root;

    BSDateRangePicker pickerA() => root.home.pickerA;
    BSDateRangePicker pickerB() => root.home.pickerB;

    int pickersInBody() =>
        document.body!.querySelectorAll('.daterangepicker').length;

    setUpAll(() async {
      rootContainer = HTMLDivElement();
      document.body!.appendChild(rootContainer);

      root = _Root(rootContainer);
      root.initialize();
      await root.onFinishRender.first;

      await _waitFor(
        () => pickerA().jsPicker != null && pickerB().jsPicker != null,
      );
    });

    tearDownAll(() => rootContainer.remove());

    test('loads without JQuery', () {
      expect(JQuery.isLoaded, isFalse);
      expect(globalContext['jQuery'], isNull);
      expect(globalContext['DateRangePicker'], isNotNull);
      expect(Moment.isSuccessfullyLoaded, isTrue);
    });

    test('JS selection calls back into Dart', () async {
      var picker = pickerA();
      var changes = <Object?>[];
      var sub = picker.onChange.listen(changes.add);

      try {
        var start = DateTime(2024, 3, 5);
        var end = DateTime(2024, 3, 9, 23, 59, 59, 999);

        var drp = picker.jsPicker!;
        drp.callMethod('show'.toJS);
        drp.callMethod('setStartDate'.toJS, Moment.moment(start));
        drp.callMethod('setEndDate'.toJS, Moment.moment(end));
        drp.callMethod('clickApply'.toJS);

        await _waitFor(() => changes.isNotEmpty);

        expect(picker.startTime, equals(start));
        expect(picker.endTime, equals(end));
      } finally {
        await sub.cancel();
      }
    });

    test('clicking the field opens the picker', () async {
      var drp = pickerA().jsPicker!;
      var container = drp['container'] as HTMLElement;

      (drp['element'] as HTMLElement).click();
      await _waitFor(() => container.style.display != 'none');
      expect(container.querySelectorAll('.drp-calendar').length, equals(2));

      drp.callMethod('hide'.toJS);
      expect(container.style.display, equals('none'));
    });

    test('a click on the other picker field closes the open picker', () {
      var drpA = pickerA().jsPicker!;
      var elementB = pickerB().jsPicker!['element'] as HTMLElement;

      drpA.callMethod('show'.toJS);
      expect((drpA['isShowing'] as JSBoolean).toDart, isTrue);

      // Same tag and classes (`div.form-control`) as picker A's element:
      elementB.dispatchEvent(
        MouseEvent('mousedown', MouseEventInit(bubbles: true)),
      );

      expect((drpA['isShowing'] as JSBoolean).toDart, isFalse);
      expect((drpA['container'] as HTMLElement).style.display, equals('none'));
    });

    test('a click inside the picker keeps it open', () {
      var drpA = pickerA().jsPicker!;
      drpA.callMethod('show'.toJS);
      try {
        var container = drpA['container'] as HTMLElement;
        container
            .querySelector('.ranges')!
            .dispatchEvent(
              MouseEvent('mousedown', MouseEventInit(bubbles: true)),
            );
        expect((drpA['isShowing'] as JSBoolean).toDart, isTrue);
      } finally {
        drpA.callMethod('hide'.toJS);
      }
    });

    test('a new render removes the previous JS picker', () async {
      var before = pickersInBody();
      var prevJsPicker = pickerA().jsPicker!;
      prevJsPicker.callMethod('show'.toJS);

      pickerA().refresh();
      await _waitFor(() => !identical(pickerA().jsPicker, prevJsPicker));
      await _waitFor(() => pickersInBody() == before);

      expect(prevJsPicker['container'], isNull);
      expect((prevJsPicker['isShowing'] as JSBoolean).toDart, isFalse);
      expect(JQuery.isLoaded, isFalse);
    });

    test(
      'a render from `onChange` while applying completes the apply',
      () async {
        var picker = pickerA();
        var drp = picker.jsPicker!;
        var element = drp['element'] as HTMLElement;

        var applyEvents = 0;
        void onApply(Event _) => ++applyEvents;
        var onApplyJS = onApply.toJS;
        element.addEventListener('apply.daterangepicker', onApplyJS);

        // A synchronous listener re-rendering the picker (the JS picker is
        // still inside `hide()`, called by `clickApply`):
        var sub = picker.onChange.listen((_) => picker.refresh());

        try {
          drp.callMethod('show'.toJS);
          drp.callMethod(
            'setStartDate'.toJS,
            Moment.moment(DateTime(2023, 1, 2)),
          );
          drp.callMethod(
            'setEndDate'.toJS,
            Moment.moment(DateTime(2023, 1, 3)),
          );
          drp.callMethod('clickApply'.toJS);

          expect(applyEvents, equals(1));
          expect(picker.startTime, equals(DateTime(2023, 1, 2)));

          await _waitFor(() => !identical(picker.jsPicker, drp));
          await _waitFor(() => drp['container'] == null);
        } finally {
          await sub.cancel();
          element.removeEventListener('apply.daterangepicker', onApplyJS);
        }
      },
    );

    test('clear removes the JS picker', () async {
      var before = pickersInBody();

      pickerB().clear();

      expect(pickerB().jsPicker, isNull);
      await _waitFor(() => pickersInBody() == before - 1);
    });
  });
}

Future<void> _waitFor(
  bool Function() condition, {
  Duration timeout = const Duration(seconds: 5),
}) async {
  var init = DateTime.now();
  while (!condition()) {
    if (DateTime.now().difference(init) > timeout) {
      throw TimeoutException('Condition not met', timeout);
    }
    await Future.delayed(Duration(milliseconds: 20));
  }
}

class _Root extends UIRoot {
  _Root(super.rootContainer);

  late final _Home home;

  @override
  UIComponent? renderContent() => home = _Home(content!);
}

class _Home extends UIComponent {
  _Home(super.parent);

  late final BSDateRangePicker pickerA = BSDateRangePicker(
    content!,
    rangesTypes: [DateRangeType.today],
  );

  late final BSDateRangePicker pickerB = BSDateRangePicker(
    content!,
    rangesTypes: [DateRangeType.today],
  );

  @override
  render() => [pickerA, pickerB];
}
