@TestOn('browser')
library;

import 'dart:js_interop_unsafe';

import 'package:bones_ui/bones_ui.dart';
import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';
import 'package:dom_tools/dom_tools.dart';
import 'package:swiss_knife/swiss_knife.dart';
import 'package:test/test.dart';
import 'package:web_utils/web_utils.dart';

/// Integration tests: load the real JS libraries (JQuery, Bootstrap, Moment,
/// Date Range Picker) bundled in this package and drive them from Dart.
void main() {
  group('Integration: JS libraries', () {
    test('JQuery.load', () async {
      expect(await JQuery.load(), isTrue);
      expect(JQuery.isLoaded, isTrue);
      expect(JQuery.isSuccessfullyLoaded, isTrue);
      expect(globalContext['jQuery'], isNotNull);
    });

    test('Bootstrap.load', () async {
      expect(await Bootstrap.load(), isTrue);
      expect(Bootstrap.isSuccessfullyLoaded, isTrue);

      var bsLink = document.querySelector(
        'link[href*="bootstrap-${Bootstrap.VERSION}"]',
      );
      expect(bsLink, isNotNull);

      // Bootstrap 5 JS API (`window.bootstrap`):
      var bootstrap = globalContext['bootstrap'] as JSObject;
      expect(bootstrap['Collapse'], isNotNull);
      expect(bootstrap['Tooltip'], isNotNull);
    });

    test('Bootstrap.load: idempotent', () async {
      expect(await Bootstrap.load(), isTrue);
      expect(await Bootstrap.load(), isTrue);
      expect(
        document
            .querySelectorAll('link[href*="bootstrap-${Bootstrap.VERSION}"]')
            .length,
        equals(1),
      );
    });

    test('Moment.load', () async {
      expect(await Moment.load(), isTrue);
      expect(Moment.isSuccessfullyLoaded, isTrue);
    });
  });

  group('Integration: JQuery', () {
    setUpAll(() => JQuery.load());

    test(r'$(selector).call', () {
      var div = HTMLDivElement()
        ..id = 'jq-test'
        ..appendChild(createHTML(html: '<span class="jq-item">a</span>'))
        ..appendChild(createHTML(html: '<span class="jq-item">b</span>'));
      document.body!.appendChild(div);

      try {
        expect(JQuery.$('#jq-test .jq-item').call('text'), equals('ab'));

        JQuery.$('#jq-test').call('addClass', ['jq-added']);
        expect(div.classList.contains('jq-added'), isTrue);

        JQuery.$('#jq-test').call('attr', ['data-x', 123]);
        expect(div.getAttribute('data-x'), equals('123'));
      } finally {
        div.remove();
      }
    });

    test(r'$(element).call', () {
      var div = HTMLDivElement()..textContent = 'hello';
      document.body!.appendChild(div);

      try {
        expect(JQuery.$(div).call('text'), equals('hello'));
        JQuery.$(div).call('text', ['world']);
        expect(div.textContent, equals('world'));
      } finally {
        div.remove();
      }
    });
  });

  group('Integration: Moment', () {
    setUpAll(() => Moment.load());

    test('moment <-> DateTime round-trip', () {
      var d = DateTime(2024, 3, 15, 10, 20, 30, 400);
      var m = Moment.moment(d);
      expect(
        Moment.jsObjectToMillisecondsSinceEpoch(m),
        equals(d.millisecondsSinceEpoch),
      );
      expect(Moment.jsObjectToDateTime(m), equals(d));
    });

    test('moment(DateTime.utc)', () {
      var d = DateTime.utc(2024, 1, 2, 3, 4, 5);
      var m = Moment.moment(d);
      expect(
        Moment.jsObjectToMillisecondsSinceEpoch(m),
        equals(d.millisecondsSinceEpoch),
      );
    });

    test('format', () {
      Moment.locale('en');
      var d = DateTime(2024, 3, 5, 14, 7);
      expect(Moment.format(d, 'YYYY-MM-DD HH:mm'), equals('2024-03-05 14:07'));
      expect(
        Moment.jsObjectFormat(Moment.moment(d), 'MMMM D'),
        equals('March 5'),
      );
    });

    test('locale', () {
      expect(Moment.locale('  '), isFalse);
      expect(Moment.locale('pt_BR'), isTrue);
      expect(Moment.format(DateTime(2024, 3, 5), 'MMMM'), equals('março'));
      expect(Moment.locale('en'), isTrue);
      expect(Moment.format(DateTime(2024, 3, 5), 'MMMM'), equals('March'));
    });
  });

  group('Integration: BSAccordion', () {
    late HTMLDivElement rootContainer;
    late _AccordionRoot root;

    setUpAll(() async {
      await Bootstrap.load();

      rootContainer = HTMLDivElement();
      document.body!.appendChild(rootContainer);

      root = _AccordionRoot(rootContainer);
      root.initialize();
      await root.onFinishRender.first;
    });

    tearDownAll(() => rootContainer.remove());

    HTMLElement collapse(int i) =>
        rootContainer.querySelector('#int-accordion-collapse-$i')
            as HTMLElement;

    HTMLElement button(int i) =>
        rootContainer.querySelector('#int-accordion-heading-$i button')
            as HTMLElement;

    test('Bootstrap collapse toggles items', () async {
      expect(collapse(0).classList.contains('show'), isTrue);
      expect(collapse(1).classList.contains('show'), isFalse);

      button(1).click();
      await _waitFor(() => collapse(1).classList.contains('show'));

      // `data-parent` closes the other items:
      await _waitFor(() => !collapse(0).classList.contains('show'));
      expect(button(1).getAttribute('aria-expanded'), equals('true'));
      expect(button(0).getAttribute('aria-expanded'), equals('false'));
    });
  });

  group('Integration: BSDateRangePicker', () {
    late HTMLDivElement rootContainer;
    late _PickerRoot root;

    setUpAll(() async {
      rootContainer = HTMLDivElement();
      document.body!.appendChild(rootContainer);

      root = _PickerRoot(rootContainer);
      root.initialize();
      await root.onFinishRender.first;
    });

    tearDownAll(() => rootContainer.remove());

    BSDateRangePicker picker() => root.home.picker;

    HTMLElement formControl() =>
        rootContainer.querySelector('.ui-bs-date-range-picker .form-control')
            as HTMLElement;

    test('renders after loading JS libraries', () async {
      await _waitFor(
        () =>
            rootContainer.querySelector(
              '.ui-bs-date-range-picker .form-control',
            ) !=
            null,
      );

      expect(Moment.isSuccessfullyLoaded, isTrue);
      expect(Bootstrap.isSuccessfullyLoaded, isTrue);
      expect(formControl().textContent, contains(picker().dateText));
      expect(
        formControl().querySelector('img[src*="calendar.svg"]'),
        isNotNull,
      );

      // The JQuery plugin is attached to the element:
      var data = JQuery.$(formControl()).call('data', ['daterangepicker']);
      expect(data, isNotNull);
    });

    test('initial range (DateRangeType.today) has a title', () {
      var today = getDateTimeRange(DateRangeType.today, DateTime.now());
      expect(picker().startTime, equals(today.a));
      expect(picker().dateText, startsWith('Today ('));
    });

    test('JS selection calls back into Dart', () async {
      var changes = <Object?>[];
      var sub = picker().onChange.listen(changes.add);

      try {
        var start = DateTime(2024, 2, 10);
        var end = DateTime(2024, 2, 20, 23, 59, 59, 999);

        var drp = _jsPicker(formControl());
        drp.callMethod('show'.toJS);
        drp.callMethod('setStartDate'.toJS, Moment.moment(start));
        drp.callMethod('setEndDate'.toJS, Moment.moment(end));
        // `clickApply` invokes the callback registered from Dart:
        drp.callMethod('clickApply'.toJS);

        await _waitFor(() => changes.isNotEmpty);

        expect(picker().startTime, equals(start));
        expect(picker().endTime, equals(end));
        expect(picker().getFieldValue().a, equals(start));
        expect(formControl().textContent, contains(picker().dateText));
      } finally {
        await sub.cancel();
      }
    });

    test('setDateRangeByType', () {
      picker().setDateRangeByType(DateRangeType.yesterday);
      var yesterday = getDateTimeRange(DateRangeType.yesterday, DateTime.now());

      expect(picker().startTime, equals(yesterday.a));
      expect(picker().dateText, startsWith('Yesterday ('));
      expect(formControl().textContent, startsWith('Yesterday ('));
    });
  });

  group('Integration: BSDateRangePicker (time picker)', () {
    late HTMLDivElement rootContainer;

    setUpAll(() async {
      rootContainer = HTMLDivElement();
      document.body!.appendChild(rootContainer);

      var root = _BuilderRoot(
        rootContainer,
        (parent) => BSDateRangePicker(
          parent,
          timePicker: TimePicker.hoursMinutesBy15,
          startTime: DateTime(2024, 4, 10, 10, 37),
          endTime: DateTime(2024, 4, 11, 18, 52),
        ),
      );
      root.initialize();
      await root.onFinishRender.first;

      await _waitFor(
        () =>
            rootContainer.querySelector(
              '.ui-bs-date-range-picker .form-control',
            ) !=
            null,
      );
    });

    tearDownAll(() => rootContainer.remove());

    test('selected minute is rounded to the time picker increment', () {
      var formControl =
          rootContainer.querySelector('.ui-bs-date-range-picker .form-control')
              as HTMLElement;

      var drp = _jsPicker(formControl);
      drp.callMethod('show'.toJS);

      try {
        var container =
            (drp['container'] as JSObject).callMethod<JSAny?>(
                  'get'.toJS,
                  0.toJS,
                )
                as HTMLElement;

        // Local patch in `daterangepicker.js`: 37 -> 30 and 52 -> 45:
        String? selectedMinute(String side) =>
            (container.querySelector(
                      '.drp-calendar.$side .minuteselect option[selected]',
                    )
                    as HTMLOptionElement?)
                ?.value;

        expect(selectedMinute('left'), equals('30'));
        expect(selectedMinute('right'), equals('45'));
      } finally {
        drp.callMethod('hide'.toJS);
      }
    });
  });
}

JSObject _jsPicker(HTMLElement element) =>
    (globalContext['jQuery'] as JSFunction)
        .callAsFunction(null, element)
        .asJSObject!
        .callMethod<JSObject>('data'.toJS, 'daterangepicker'.toJS);

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

class _AccordionRoot extends UIRoot {
  _AccordionRoot(super.rootContainer);

  @override
  UIComponent? renderContent() => _AccordionHome(content!);
}

class _AccordionHome extends UIComponent {
  _AccordionHome(super.parent);

  @override
  render() => BSAccordion(
    content!,
    [
      AccordionItem('Item A', 'aaa'),
      AccordionItem('Item B', 'bbb'),
      AccordionItem('Item C', 'ccc'),
    ],
    id: 'int-accordion',
    expandIndex: 0,
  );
}

class _BuilderRoot extends UIRoot {
  final UIComponent Function(Object parent) builder;

  _BuilderRoot(super.rootContainer, this.builder);

  @override
  UIComponent? renderContent() => builder(content!);
}

class _PickerRoot extends UIRoot {
  _PickerRoot(super.rootContainer);

  late final _PickerHome home;

  @override
  UIComponent? renderContent() => home = _PickerHome(content!);
}

class _PickerHome extends UIComponent {
  _PickerHome(super.parent);

  late final BSDateRangePicker picker = BSDateRangePicker(
    content!,
    initialRangeType: DateRangeType.today,
    rangesTypes: [
      DateRangeType.today,
      DateRangeType.yesterday,
      DateRangeType.last7Days,
    ],
  );

  @override
  render() => picker;
}
