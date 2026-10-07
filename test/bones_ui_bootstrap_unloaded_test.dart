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
  });
}
