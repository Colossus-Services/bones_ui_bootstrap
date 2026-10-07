@TestOn('browser')
library;

import 'package:web_utils/web_utils.dart';
import 'package:bones_ui/bones_ui.dart';
import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';
import 'package:swiss_knife/swiss_knife.dart';
import 'package:test/test.dart';

void main() {
  group('Components', () {
    final rootContainer = HTMLDivElement();
    late final MyRoot root;

    setUpAll(() {
      root = MyRoot(rootContainer);
    });

    test('initialize', () async {
      root.initialize();
      await root.onFinishRender.first;

      var myHome = rootContainer.querySelector('#my-home');
      expect(myHome, isA<HTMLDivElement>());
    });

    test('BSAccordion', () async {
      var myAccordion = rootContainer.querySelector('#my-accordion');
      expect(myAccordion, isA<HTMLDivElement>());
      expect(myAccordion!.classList.contains('accordion'), isTrue);
      expect(myAccordion.classList.contains('ui-bs-accordion'), isTrue);
      expect(myAccordion.classList.contains('accordion-flush'), isFalse);
      expect(myAccordion.classList.contains('my-accordion-class'), isTrue);
      expect(myAccordion.querySelectorAll('.accordion-item').length, equals(3));
      expect(myAccordion.querySelectorAll('.card'), isEmpty);
    });

    test('BSAccordion: item structure', () {
      var item = rootContainer.querySelector(
        '#my-accordion > .accordion-item',
      )!;
      expect(item.classList.contains('my-item'), isTrue);

      var heading = item.querySelector('#my-accordion-heading-0')!;
      expect(heading.tagName.toLowerCase(), equals('h2'));
      expect(heading.classList.contains('accordion-header'), isTrue);
      expect(heading.classList.contains('my-head'), isTrue);

      var button = heading.querySelector('button.accordion-button')!;
      expect(button.textContent, equals('Item A'));
      expect(button.getAttribute('type'), equals('button'));
      expect(button.getAttribute('data-bs-toggle'), equals('collapse'));
      expect(
        button.getAttribute('data-bs-target'),
        equals('#my-accordion-collapse-0'),
      );
      expect(
        button.getAttribute('aria-controls'),
        equals('my-accordion-collapse-0'),
      );
      // No Bootstrap 4 attributes:
      expect(button.hasAttribute('data-toggle'), isFalse);
      expect(button.hasAttribute('data-target'), isFalse);

      var collapse = item.querySelector('#my-accordion-collapse-0')!;
      expect(collapse.classList.contains('accordion-collapse'), isTrue);
      expect(collapse.classList.contains('collapse'), isTrue);
      expect(collapse.getAttribute('data-bs-parent'), equals('#my-accordion'));
      expect(collapse.hasAttribute('data-parent'), isFalse);
      expect(
        collapse.getAttribute('aria-labelledby'),
        equals('my-accordion-heading-0'),
      );

      var body = collapse.querySelector('.accordion-body')!;
      expect(body.textContent, equals('aaa'));
      expect(body.classList.contains('my-body'), isTrue);
      expect(body.getAttribute('style'), contains('color: red'));
    });

    test('BSAccordion: flush', () {
      var parent = HTMLDivElement();
      var flush = BSAccordion(parent, [AccordionItem('A', 'a')], flush: true);
      flush.ensureRendered();
      expect(flush.flush, isTrue);
      expect(flush.content!.classList.contains('accordion'), isTrue);
      expect(flush.content!.classList.contains('accordion-flush'), isTrue);

      var normal = BSAccordion(HTMLDivElement(), [AccordionItem('A', 'a')]);
      expect(normal.flush, isFalse);
    });

    test('BSAccordion: expanded items', () {
      bool isExpanded(int i) {
        var body = rootContainer.querySelector('#my-accordion-collapse-$i')!;
        var button = rootContainer.querySelector(
          '#my-accordion-heading-$i button',
        )!;

        var show = body.classList.contains('show');
        expect(button.getAttribute('aria-expanded'), equals('$show'));
        expect(button.classList.contains('collapsed'), equals(!show));
        return show;
      }

      // Item 1 has `expanded: true`, item 2 is selected by `expandIndex: -1`:
      expect(isExpanded(0), isFalse);
      expect(isExpanded(1), isTrue);
      expect(isExpanded(2), isTrue);
    });
  });

  group('BSAccordion (unit)', () {
    test('auto id', () {
      var a1 = BSAccordion(HTMLDivElement(), []);
      var a2 = BSAccordion(HTMLDivElement(), []);
      expect(a1.id, startsWith('__BSAccordion__'));
      expect(a2.id, startsWith('__BSAccordion__'));
      expect(a1.id, isNot(equals(a2.id)));
    });

    test('null id: auto-generated', () {
      var a = BSAccordion(HTMLDivElement(), [], id: null);
      expect(a.id, startsWith('__BSAccordion__'));
    });

    test('empty/blank id', () {
      for (var id in ['', '  ']) {
        expect(
          () => BSAccordion(HTMLDivElement(), [], id: id),
          throwsA(
            isA<ArgumentError>()
                .having((e) => e.name, 'name', equals('id'))
                .having((e) => e.invalidValue, 'invalidValue', equals(id))
                .having(
                  (e) => e.message,
                  'message',
                  allOf(contains('empty or blank'), contains('`null`')),
                ),
          ),
        );
      }
    });

    test('expandIndex', () {
      var items = [
        AccordionItem('A', 'a'),
        AccordionItem('B', 'b'),
        AccordionItem('C', 'c'),
      ];

      List<bool> expandedOf(int? expandIndex) {
        var parent = HTMLDivElement();
        var accordion = BSAccordion(
          parent,
          items,
          id: 'acc-x',
          expandIndex: expandIndex,
        );
        accordion.ensureRendered();
        return List.generate(
          items.length,
          (i) => accordion.content!
              .querySelector('#acc-x-collapse-$i')!
              .classList
              .contains('show'),
        );
      }

      expect(expandedOf(null), equals([false, false, false]));
      expect(expandedOf(0), equals([true, false, false]));
      expect(expandedOf(2), equals([false, false, true]));
      expect(expandedOf(-1), equals([false, false, true]));
      expect(expandedOf(-3), equals([true, false, false]));
      expect(expandedOf(5), equals([false, false, false]));
    });
  });

  group('BootstrapIcons', () {
    test('getIconPath', () {
      expect(
        BootstrapIcons.getIconPath('calendar'),
        equals('packages/bones_ui_bootstrap/icons/calendar.svg'),
      );
      expect(
        BootstrapIcons.getIconPath(' Calendar.SVG '.trim()),
        equals('packages/bones_ui_bootstrap/icons/calendar.svg'),
      );
      expect(BootstrapIcons.getIconPath(''), isNull);
      expect(BootstrapIcons.getIconPath('no-such-icon-xyz'), isNull);
    });

    test('allIcons', () {
      var all = BootstrapIcons.allIcons;
      expect(all.length, greaterThan(1000));
      expect(all, contains('calendar'));
      expect(all.toSet().length, equals(all.length));
      expect(all.every((e) => e.isNotEmpty && e == e.trim()), isTrue);

      // A copy: changes don't affect the icons list.
      all.clear();
      expect(BootstrapIcons.allIcons, isNotEmpty);
    });

    test('svgIconHTML', () {
      expect(
        BootstrapIcons.svgIconHTML('calendar'),
        equals('<img src="packages/bones_ui_bootstrap/icons/calendar.svg">'),
      );

      expect(
        BootstrapIcons.svgIconHTML(
          'calendar',
          title: 'Cal',
          width: 16,
          height: 20,
          classes: 'c1 c2',
          style: 'color: red',
        ),
        equals(
          '<img src="packages/bones_ui_bootstrap/icons/calendar.svg"'
          ' width=16 height=20 title="Cal" class="c1 c2" style="color: red">',
        ),
      );

      expect(BootstrapIcons.svgIconHTML('no-such-icon-xyz'), isNull);
    });

    test('svgIconElement', () {
      var e = BootstrapIcons.svgIconElement('calendar', width: 24);
      expect(e, isA<HTMLImageElement>());
      expect(e.getAttribute('src'), endsWith('icons/calendar.svg'));
      expect(e.getAttribute('width'), equals('24'));
    });

    test('svgResourceContent', () async {
      expect(BootstrapIcons.svgResourceContent('no-such-icon-xyz'), isNull);

      var content = BootstrapIcons.svgResourceContent('calendar')!;
      var svg = await content.getContent();
      expect(svg, contains('<svg'));
    });
  });

  group('Moment (unit)', () {
    test('toMomentWeekDay / toDateTimeWeekDay', () {
      expect(Moment.toMomentWeekDay(null), isNull);

      for (var weekDay in DateTimeWeekDay.values) {
        var idx = Moment.toMomentWeekDay(weekDay)!;
        expect(idx, inInclusiveRange(0, 6));
        expect(Moment.toDateTimeWeekDay(idx), equals(weekDay));
      }

      expect(Moment.toMomentWeekDay(DateTimeWeekDay.sunday), equals(0));
      expect(Moment.toMomentWeekDay(DateTimeWeekDay.saturday), equals(6));

      expect(() => Moment.toDateTimeWeekDay(-1), throwsArgumentError);
      expect(() => Moment.toDateTimeWeekDay(7), throwsArgumentError);
    });
  });

  group('BSDateRangePicker (unit)', () {
    test('defaults', () {
      var picker = BSDateRangePicker(HTMLDivElement());
      expect(picker.fieldName, equals('date-range-picker'));
      expect(picker.timePicker, equals(TimePicker.none));
      expect(picker.hasTimePicker, isFalse);

      var now = DateTime.now();
      expect(picker.startTime, equals(getDateTimeDayStart(now)));
      expect(picker.endTime, equals(getDateTimeDayEnd(now)));
    });

    test('explicit start/end', () {
      var start = DateTime(2024, 1, 1);
      var end = DateTime(2024, 1, 31, 23, 59, 59, 999);

      var picker = BSDateRangePicker(
        HTMLDivElement(),
        fieldName: 'period',
        timePicker: TimePicker.hoursMinutesBy15,
        startTime: start,
        endTime: end,
      );

      expect(picker.fieldName, equals('period'));
      expect(picker.hasTimePicker, isTrue);
      expect(picker.dateTimeRange.a, equals(start));
      expect(picker.dateTimeRange.b, equals(end));
      expect(picker.getFieldValue().a, equals(start));
    });

    test('initialRangeType', () {
      var picker = BSDateRangePicker(
        HTMLDivElement(),
        initialRangeType: DateRangeType.last7Days,
      );
      var range = getDateTimeRange(DateRangeType.last7Days, DateTime.now());
      expect(picker.startTime, equals(range.a));
      expect(picker.endTime, equals(range.b));
    });

    test('setFieldValue', () {
      var picker = BSDateRangePicker(
        HTMLDivElement(),
        initialRangeType: DateRangeType.yesterday,
      );

      var start = DateTime(2023, 5, 1);
      var end = DateTime(2023, 5, 2);
      picker.setFieldValue(Pair(start, end));
      expect(picker.startTime, equals(start));
      expect(picker.endTime, equals(end));

      // `null` resets to `initialRangeType`:
      picker.setFieldValue(null);
      var yesterday = getDateTimeRange(DateRangeType.yesterday, DateTime.now());
      expect(picker.startTime, equals(yesterday.a));
      expect(picker.endTime, equals(yesterday.b));
    });

    test('setDateRange normalizes seconds and notifies onChange', () async {
      var picker = BSDateRangePicker(HTMLDivElement());

      var changes = <Object?>[];
      picker.onChange.listen(changes.add);

      picker.setDateRange(
        DateTime(2024, 6, 1, 8, 30, 45, 123),
        DateTime(2024, 6, 3, 17, 15, 5, 7),
      );

      expect(picker.startTime, equals(DateTime(2024, 6, 1, 8, 30, 0, 0)));
      expect(picker.endTime, equals(DateTime(2024, 6, 3, 17, 15, 59, 999)));

      await Future.delayed(Duration.zero);
      expect(changes, equals([picker]));
    });

    test('setDateRangeByType (not rendered)', () {
      var picker = BSDateRangePicker(HTMLDivElement());
      picker.setDateRangeByType(DateRangeType.today);

      var today = getDateTimeRange(DateRangeType.today, DateTime.now());
      expect(picker.startTime, equals(today.a));
      expect(picker.endTime, equals(today.b));
    });
  });
}

class MyRoot extends UIRoot {
  MyRoot(super.rootContainer);

  @override
  UIComponent? renderContent() => MyHome(content!);
}

class MyHome extends UIComponent {
  MyHome(super.parent) : super(id: 'my-home');

  @override
  render() => BSAccordion(
    content!,
    [
      AccordionItem(
        'Item A',
        'aaa',
        classes: 'my-item',
        headClasses: 'my-head',
        bodyClasses: 'my-body',
        bodyStyle: 'color: red',
      ),
      AccordionItem('Item B', 'bbb', expanded: true),
      AccordionItem('Item C', 'ccc'),
    ],
    id: 'my-accordion',
    expandIndex: -1,
    classes: 'my-accordion-class',
  );
}
