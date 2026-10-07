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

    test('clicking the open item collapses it', () async {
      // After the previous test, item 1 is open:
      await _waitFor(
        () => e('#acc-normal-collapse-1').classList.contains('show'),
      );

      e('#acc-normal-heading-1 button').click();

      await _waitFor(
        () => !e('#acc-normal-collapse-1').classList.contains('show'),
      );
      var button = e('#acc-normal-heading-1 button');
      expect(button.getAttribute('aria-expanded'), equals('false'));
      expect(button.classList.contains('collapsed'), isTrue);

      // All items closed:
      expect(rootContainer.querySelectorAll('#acc-normal .show').length, 0);
    });

    test('Bootstrap Collapse instance controls the items', () async {
      var collapseClass =
          (globalContext['bootstrap'] as JSObject)['Collapse'] as JSObject;

      var instance = collapseClass.callMethod<JSObject>(
        'getOrCreateInstance'.toJS,
        e('#acc-normal-collapse-2'),
        {'toggle': false}.toJSDeep,
      );
      instance.callMethod<JSAny?>('show'.toJS);

      await _waitFor(
        () => e('#acc-normal-collapse-2').classList.contains('show'),
      );
      expect(
        e('#acc-normal-heading-2 button').getAttribute('aria-expanded'),
        equals('true'),
      );
    });

    test('items with DOM and component content', () {
      var title = e('#acc-rich-heading-0 button');
      expect(title.querySelector('b.rich-title')?.textContent, 'Rich');

      var body = e('#acc-rich-collapse-0 .accordion-body');
      expect(body.querySelector('.rich-body')?.textContent, 'Body text');
      expect(body.querySelector('.rich-component')?.textContent, 'Component');
    });

    test('item classes and styles', () {
      var item = e('#acc-rich > .accordion-item');
      expect(item.classList.contains('rich-item'), isTrue);
      expect(item.style.getPropertyValue('margin-top'), equals('3px'));

      var header = e('#acc-rich-heading-0');
      expect(header.classList.contains('rich-head'), isTrue);
      expect(header.style.getPropertyValue('font-size'), equals('12px'));
    });

    test('multiple items expanded by `AccordionItem.expanded`', () {
      expect(e('#acc-rich-collapse-0').classList.contains('show'), isTrue);
      expect(e('#acc-rich-collapse-1').classList.contains('show'), isTrue);
    });
  });

  group('Bootstrap 5: bundled versions', () {
    test('Bootstrap JS version', () {
      var tooltip =
          (globalContext['bootstrap'] as JSObject)['Tooltip'] as JSObject;
      expect(
        (tooltip['VERSION'] as JSString).toDart,
        equals(Bootstrap.VERSION),
      );
    });

    test('Bootstrap CSS is the first stylesheet', () {
      var links = document.querySelectorAll('link[rel="stylesheet"]');
      expect(links.length, greaterThan(0));
      var first = links.item(0) as HTMLLinkElement;
      expect(first.href, contains('bootstrap-${Bootstrap.VERSION}/css/'));
    });

    test('Bootstrap 5 CSS utilities', () {
      var div = HTMLDivElement();
      document.body!.appendChild(div);
      try {
        HTMLElement add(String classes) {
          var el = HTMLSpanElement()..className = classes;
          div.appendChild(el);
          return el;
        }

        CSSStyleDeclaration s(HTMLElement el) => window.getComputedStyle(el);

        // Bootstrap 5 only classes:
        expect(s(add('ms-3')).marginLeft, equals('16px'));
        expect(s(add('me-2')).marginRight, equals('8px'));
        expect(s(add('fw-bold')).fontWeight, equals('700'));
        expect(s(add('visually-hidden')).position, equals('absolute'));
        expect(s(add('d-none')).display, equals('none'));
      } finally {
        div.remove();
      }
    });
  });

  group('Bootstrap 5: tooltip (rendering)', () {
    test('tooltip is shown with the `data-bs-title`', () async {
      var button = createHTML(
        html:
            '<button data-bs-toggle="tooltip" data-bs-title="Shown title"'
            ' data-bs-animation="false">Hover</button>',
      );
      document.body!.appendChild(button);

      try {
        await Bootstrap.enableTooltip(force: true, delay: Duration.zero);

        var instance =
            ((globalContext['bootstrap'] as JSObject)['Tooltip'] as JSObject)
                .callMethod<JSObject>('getInstance'.toJS, button);
        instance.callMethod<JSAny?>('show'.toJS);

        await _waitFor(() => document.querySelector('.tooltip.show') != null);

        var tip = document.querySelector('.tooltip.show')!;
        expect(tip.textContent, equals('Shown title'));
        expect(button.getAttribute('aria-describedby'), equals(tip.id));

        instance.callMethod<JSAny?>('dispose'.toJS);
      } finally {
        button.remove();
      }
    });

    test('enableTooltipOnRender', () async {
      var container = HTMLDivElement();
      document.body!.appendChild(container);

      try {
        var root = _TooltipRoot(container);
        root.initialize();
        await root.onFinishRender.first;

        var button = container.querySelector('#on-render-tooltip')!;
        var tooltipClass =
            (globalContext['bootstrap'] as JSObject)['Tooltip'] as JSObject;

        // Enabled ~1s after render:
        await _waitFor(
          () =>
              tooltipClass.callMethod<JSAny?>('getInstance'.toJS, button) !=
              null,
          timeout: Duration(seconds: 5),
        );
      } finally {
        container.remove();
      }
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
    BSAccordion(content!, [
      AccordionItem(
        createHTML(html: '<b class="rich-title">Rich</b>'),
        [
          createHTML(html: '<p class="rich-body">Body text</p>'),
          _TextComponent(null, 'Component'),
        ],
        expanded: true,
        classes: 'rich-item',
        style: 'margin-top: 3px',
        headClasses: 'rich-head',
        headStyle: 'font-size: 12px',
      ),
      AccordionItem('Second', 'second', expanded: true),
    ], id: 'acc-rich'),
  ];
}

class _TextComponent extends UIComponent {
  final String text;

  _TextComponent(super.parent, this.text) : super(classes: 'rich-component');

  @override
  render() => text;
}

class _TooltipRoot extends UIRoot {
  _TooltipRoot(super.rootContainer);

  @override
  UIComponent? renderContent() {
    var page = _TooltipPage(content!);
    Bootstrap.enableTooltipOnRender(page);
    return page;
  }
}

class _TooltipPage extends UIComponent {
  _TooltipPage(super.parent);

  @override
  render() =>
      '<button id="on-render-tooltip" data-bs-toggle="tooltip"'
      ' data-bs-title="On render">Hover</button>';
}
