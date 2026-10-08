@TestOn('browser')
library;

import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';
import 'package:test/test.dart';
import 'package:web_utils/web_utils.dart';

/// Tests of `Bootstrap.defaultLoadCss = false`: the first `Bootstrap.load`
/// call, made by this package (`Bootstrap.enableTooltip`), doesn't load the
/// bundled CSS.
void main() {
  group('Bootstrap.defaultLoadCss = false', () {
    test('a load made by the package uses it', () async {
      Bootstrap.defaultLoadCss = false;
      expect(Bootstrap.isLoaded, isFalse);

      // `enableTooltip` calls `load()` without `loadCss`:
      await Bootstrap.enableTooltip(delay: Duration.zero);

      expect(Bootstrap.isSuccessfullyLoaded, isTrue);
      expect(Bootstrap.isCssLoaded, isFalse);
      expect(
        document.querySelectorAll('link[href*="bootstrap-5"]').length,
        equals(0),
      );
    });
  });
}
