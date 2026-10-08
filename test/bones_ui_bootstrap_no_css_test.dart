@TestOn('browser')
library;

import 'dart:js_interop_unsafe';

import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';
import 'package:test/test.dart';
import 'package:web_utils/web_utils.dart';

/// Tests of `Bootstrap.load(loadCss: false)`: only the Bootstrap JS is loaded
/// (for apps that compile their own Bootstrap CSS from the bundled SCSS).
void main() {
  group('Bootstrap.load(loadCss: false)', () {
    test('CSS not loaded before load', () {
      expect(Bootstrap.isLoaded, isFalse);
      expect(Bootstrap.isCssLoaded, isNull);
    });

    test('loads only the JS', () async {
      expect(await Bootstrap.load(loadCss: false), isTrue);
      expect(Bootstrap.isSuccessfullyLoaded, isTrue);
      expect(Bootstrap.isCssLoaded, isFalse);

      var bootstrap = globalContext['bootstrap'] as JSObject;
      expect(bootstrap['Collapse'], isNotNull);
      expect(bootstrap['Tooltip'], isNotNull);

      var links = document.querySelectorAll('link[rel="stylesheet"]');
      for (var i = 0; i < links.length; ++i) {
        var link = links.item(i) as HTMLLinkElement;
        expect(link.href, isNot(contains('bootstrap-${Bootstrap.VERSION}')));
      }
    });

    test('no Bootstrap CSS applied', () {
      var span = HTMLSpanElement()..className = 'ms-3 d-none';
      document.body!.appendChild(span);
      try {
        var s = window.getComputedStyle(span);
        expect(s.marginLeft, equals('0px'));
        expect(s.display, isNot(equals('none')));
      } finally {
        span.remove();
      }
    });

    test('later calls keep the first options', () async {
      expect(await Bootstrap.load(), isTrue);
      expect(Bootstrap.isCssLoaded, isFalse);
      expect(
        document.querySelectorAll('link[href*="bootstrap-5"]').length,
        equals(0),
      );
    });
  });
}
