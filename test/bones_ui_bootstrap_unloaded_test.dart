@TestOn('browser')
library;

import 'dart:js_interop_unsafe';

import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';
import 'package:test/test.dart';
import 'package:web_utils/web_utils.dart';

/// Tests with the JS libraries NOT loaded (nothing is loaded in this file
/// before the checks).
void main() {
  group('Without loaded JS libraries', () {
    test('nothing loaded', () {
      expect(Moment.isLoaded, isFalse);
      expect(JQuery.isLoaded, isFalse);
      expect(Bootstrap.isLoaded, isFalse);
      expect(globalContext['jQuery'], isNull);
    });

    test('Moment.locale: not loaded yet', () async {
      expect(Moment.locale('  '), isFalse);
      // Triggers the load, but doesn't throw:
      expect(Moment.locale('en'), isFalse);

      expect(await Moment.load(), isTrue);
      expect(Moment.locale('en'), isTrue);
    });

    test('JQuery.openWindow without JQuery', () {
      expect(globalContext['jQuery'], isNull);

      var w = JQuery.openWindow(html: '<p id="ow">Hello <b>window</b></p>');
      try {
        var doc = w['document'] as JSObject;
        var p = doc.callMethod<JSObject?>('getElementById'.toJS, 'ow'.toJS);
        expect(p, isNotNull);
        expect((p!['textContent'] as JSString).toDart, equals('Hello window'));
      } finally {
        w.callMethod<JSAny?>('close'.toJS);
      }
    });
  });
}
