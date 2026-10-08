@TestOn('browser')
library;

import 'dart:js_interop_unsafe';

import 'package:bones_ui/bones_ui.dart';
import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';
import 'package:swiss_knife/swiss_knife.dart';
import 'package:test/test.dart';
import 'package:web_utils/web_utils.dart';

/// `BSDateRangePicker` without JQuery (never loaded in this test file).
void main() {
  group('BSDateRangePicker (no JQuery)', () {
    late HTMLDivElement rootContainer;
    late _Root root;

    setUpAll(() async {
      rootContainer = HTMLDivElement();
      document.body!.appendChild(rootContainer);

      root = _Root(rootContainer);
      root.initialize();
      await root.onFinishRender.first;

      await _waitFor(() => root.picker.jsPicker != null);
    });

    tearDownAll(() => rootContainer.remove());

    test('loads without JQuery', () {
      expect(JQuery.isLoaded, isFalse);
      expect(globalContext['jQuery'], isNull);
      expect(globalContext['DateRangePicker'], isNotNull);
      expect(Moment.isSuccessfullyLoaded, isTrue);
    });

    test('JS selection calls back into Dart', () async {
      var picker = root.picker;
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
      var drp = root.picker.jsPicker!;
      var container = drp['container'] as HTMLElement;

      (drp['element'] as HTMLElement).click();
      await _waitFor(() => container.style.display != 'none');
      expect(container.querySelectorAll('.drp-calendar').length, equals(2));

      drp.callMethod('hide'.toJS);
      expect(container.style.display, equals('none'));
    });

    test('a new render removes the previous JS picker', () async {
      int pickersInBody() =>
          document.body!.querySelectorAll('.daterangepicker').length;

      var before = pickersInBody();
      var prevJsPicker = root.picker.jsPicker;

      root.picker.refresh();
      await _waitFor(() => !identical(root.picker.jsPicker, prevJsPicker));

      expect(pickersInBody(), equals(before));
      expect(JQuery.isLoaded, isFalse);
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

  late final BSDateRangePicker picker;

  @override
  UIComponent? renderContent() =>
      picker = BSDateRangePicker(content!, rangesTypes: [DateRangeType.today]);
}
