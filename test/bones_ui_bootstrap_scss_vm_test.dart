@TestOn('vm')
library;

import 'dart:io';

import 'package:package_config/package_config.dart';
import 'package:sass/sass.dart' as sass;
import 'package:test/test.dart';

/// Compiles the bundled Bootstrap SCSS through its `package:` URL, as an app
/// theme would import it.
void main() {
  final bootstrapVersion =
      RegExp('class Bootstrap \\{.*?VERSION = \'([^\']+)\'', dotAll: true)
          .firstMatch(
            File('lib/src/bones_ui_bootstrap_base.dart').readAsStringSync(),
          )!
          .group(1)!;

  // Only the major version in the SCSS path (`Bootstrap.PATH_SCSS`):
  final scssDir = 'bootstrap-${bootstrapVersion.split('.').first}/scss';

  final scssPackagePath = 'package:bones_ui_bootstrap/$scssDir';

  late PackageConfig packageConfig;

  setUpAll(() async {
    packageConfig = (await findPackageConfig(Directory.current))!;
  });

  String compile(String source) => sass
      .compileStringToResult(
        source,
        packageConfig: packageConfig,
        // Bootstrap 5.3 SCSS uses `@import` and global built-in functions,
        // deprecated in Dart Sass:
        logger: sass.Logger.quiet,
      )
      .css;

  group('Bootstrap SCSS', () {
    test('bundled sources match Bootstrap.VERSION', () {
      var dir = 'lib/$scssDir';
      expect(
        File('$dir/bootstrap.scss').readAsStringSync(),
        contains('@import "variables";'),
      );
      expect(
        File('$dir/mixins/_banner.scss').readAsStringSync(),
        contains('Bootstrap #{\$file} v$bootstrapVersion '),
      );
      expect(
        Directory('lib/bootstrap-$bootstrapVersion/scss').existsSync(),
        isFalse,
        reason: 'SCSS only in `$scssDir` (major version)',
      );
    });

    test('README import path', () {
      expect(
        File('README.md').readAsStringSync(),
        contains('@import "$scssPackagePath/bootstrap";'),
      );
    });

    test('compiles with the default variables', () {
      var css = compile('@import "$scssPackagePath/bootstrap";');

      expect(css, contains('Bootstrap  v$bootstrapVersion '));
      expect(css, contains('--bs-primary: #0d6efd;'));
      expect(css, contains('.accordion-button'));
      expect(css, contains('.ms-3'));
    });

    test('compiles a custom theme', () {
      var css = compile('''
        \$primary: #a2a2a2;
        \$dark: #343434;
        \$body-bg: #1b1a16;
        @import "$scssPackagePath/bootstrap";
      ''');

      expect(css, contains('--bs-primary: #a2a2a2;'));
      expect(css, contains('--bs-dark: #343434;'));
      expect(css, contains('--bs-body-bg: #1b1a16;'));
      expect(css, contains('--bs-btn-bg: #a2a2a2;'));
      // The default primary (`$blue`) only remains as `--bs-blue`:
      expect(
        '#0d6efd'.allMatches(css).length,
        equals('--bs-blue: #0d6efd;'.allMatches(css).length),
      );
    });

    test('variables and mixins only: no CSS output', () {
      var css = compile('''
        @import "$scssPackagePath/functions";
        @import "$scssPackagePath/variables";
        @import "$scssPackagePath/variables-dark";
        @import "$scssPackagePath/maps";
        @import "$scssPackagePath/mixins";
        @import "$scssPackagePath/utilities";
      ''');

      expect(css.trim(), isEmpty);
    });
  });
}
