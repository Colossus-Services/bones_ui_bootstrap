@TestOn('browser')
library;

import 'dart:js_interop_unsafe';

import 'package:bones_ui/bones_ui.dart';
import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';
import 'package:dom_tools/dom_tools.dart';
import 'package:test/test.dart';
import 'package:web_utils/web_utils.dart';

/// Integration tests of Bootstrap 5 without JQuery (never loaded in this
/// test file).
void main() {
  setUpAll(() async {
    expect(await Bootstrap.load(), isTrue);
  });

  group('Bootstrap 5 (no JQuery)', () {
    test('Bootstrap.load does not load JQuery', () {
      expect(Bootstrap.VERSION, equals('5.3.7'));
      expect(Bootstrap.isSuccessfullyLoaded, isTrue);
      expect(JQuery.isLoaded, isFalse);
      expect(globalContext['jQuery'], isNull);

      var bootstrap = globalContext['bootstrap'] as JSObject;
      expect(bootstrap['Collapse'], isNotNull);
      expect(bootstrap['Tooltip'], isNotNull);
    });

    test('JQuery.openWindow', () {
      var w = JQuery.openWindow(html: '<p id="ow">Hello <b>window</b></p>');
      try {
        var doc = w['document'] as JSObject;
        var p = doc.callMethod<JSObject?>('getElementById'.toJS, 'ow'.toJS);
        expect(p, isNotNull);
        expect((p!['textContent'] as JSString).toDart, equals('Hello window'));
      } finally {
        w.callMethod<JSAny?>('close'.toJS);
      }
      expect(globalContext['jQuery'], isNull);
    });
  });

  group('Bootstrap 5: tooltip', () {
    late HTMLDivElement div;

    setUp(() {
      div = HTMLDivElement();
      document.body!.appendChild(div);
    });

    tearDown(() => div.remove());

    JSObject tooltipClass() =>
        (globalContext['bootstrap'] as JSObject)['Tooltip'] as JSObject;

    JSAny? tooltipInstance(Element e) =>
        tooltipClass().callMethod<JSAny?>('getInstance'.toJS, e);

    test('enableTooltip: `data-bs-toggle="tooltip"`', () async {
      var bs5 = createHTML(
        html:
            '<button data-bs-toggle="tooltip" data-bs-title="BS5">BS5</button>',
      );
      var bs4 = createHTML(
        html: '<button data-toggle="tooltip" title="BS4">BS4</button>',
      );
      div
        ..appendChild(bs5)
        ..appendChild(bs4);

      expect(tooltipInstance(bs5), isNull);

      var ok = await Bootstrap.enableTooltip(force: true, delay: Duration.zero);
      expect(ok, isTrue);

      expect(tooltipInstance(bs5), isNotNull);
      // Bootstrap 4 attributes are not supported:
      expect(tooltipInstance(bs4), isNull);
    });

    test('enableTooltip: no elements', () async {
      div.appendChild(HTMLSpanElement()..textContent = 'no tooltip');
      expect(
        await Bootstrap.enableTooltip(force: true, delay: Duration.zero),
        isFalse,
      );
    });
  });

  group('Bootstrap 5: BSAccordion', () {
    late HTMLDivElement rootContainer;

    setUpAll(() async {
      rootContainer = HTMLDivElement();
      document.body!.appendChild(rootContainer);

      var root = _Root(rootContainer);
      root.initialize();
      await root.onFinishRender.first;
    });

    tearDownAll(() => rootContainer.remove());

    HTMLElement e(String selector) =>
        rootContainer.querySelector(selector) as HTMLElement;

    CSSStyleDeclaration style(String selector) =>
        window.getComputedStyle(e(selector));

    test('Bootstrap 5 styles apply (`accordion` class)', () {
      var button = style('#acc-normal-heading-0 .accordion-button');
      // `--bs-accordion-btn-padding-x` is defined by `.accordion`:
      expect(button.paddingLeft, isNot(equals('0px')));
      expect(button.display, equals('flex'));
    });

    test('collapse toggles with Bootstrap JS (no JQuery)', () async {
      expect(e('#acc-normal-collapse-0').classList.contains('show'), isTrue);
      expect(e('#acc-normal-collapse-1').classList.contains('show'), isFalse);

      e('#acc-normal-heading-1 button').click();

      await _waitFor(
        () => e('#acc-normal-collapse-1').classList.contains('show'),
      );
      // `data-bs-parent` closes the other items:
      await _waitFor(
        () => !e('#acc-normal-collapse-0').classList.contains('show'),
      );
      expect(
        e('#acc-normal-heading-1 button').getAttribute('aria-expanded'),
        equals('true'),
      );
      expect(globalContext['jQuery'], isNull);
    });

    test('flush: no outer borders and no rounded corners', () {
      var normalFirst = style('#acc-normal > .accordion-item:first-child');
      var flushFirst = style('#acc-flush > .accordion-item:first-child');

      expect(normalFirst.borderTopWidth, isNot(equals('0px')));
      expect(normalFirst.borderTopLeftRadius, isNot(equals('0px')));

      expect(flushFirst.borderTopWidth, equals('0px'));
      expect(flushFirst.borderLeftWidth, equals('0px'));
      expect(flushFirst.borderTopLeftRadius, equals('0px'));

      // Lines between items are kept (the bottom border of each item,
      // except the last one):
      expect(flushFirst.borderBottomWidth, isNot(equals('0px')));
      var flushLast = style('#acc-flush > .accordion-item:last-child');
      expect(flushLast.borderBottomWidth, equals('0px'));
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

  @override
  UIComponent? renderContent() => _Home(content!);
}

class _Home extends UIComponent {
  _Home(super.parent);

  @override
  render() => [
    BSAccordion(
      content!,
      [
        AccordionItem('Item A', 'aaa'),
        AccordionItem('Item B', 'bbb'),
        AccordionItem('Item C', 'ccc'),
      ],
      id: 'acc-normal',
      expandIndex: 0,
    ),
    BSAccordion(
      content!,
      [AccordionItem('Item A', 'aaa'), AccordionItem('Item B', 'bbb')],
      id: 'acc-flush',
      flush: true,
    ),
  ];
}
