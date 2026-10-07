@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';

/// Consistency checks between the package files (versions, bundled assets
/// and local patches). Reads the files directly (the library itself can't be
/// imported in the VM).
void main() {
  final base = File('lib/src/bones_ui_bootstrap_base.dart').readAsStringSync();

  String versionOf(String className) {
    var m = RegExp(
      'class $className \\{.*?VERSION = \'([^\']+)\'',
      dotAll: true,
    ).firstMatch(base);
    if (m == null) throw StateError('$className.VERSION not found');
    return m.group(1)!;
  }

  final bootstrapVersion = versionOf('Bootstrap');
  final jqueryVersion = versionOf('JQuery');
  final momentVersion = versionOf('Moment');

  final iconsVersion = RegExp(r"VERSION = '([^']+)'")
      .firstMatch(
        File('lib/src/bones_ui_bootstrap_icons.dart').readAsStringSync(),
      )!
      .group(1)!;

  group('versions', () {
    test('pubspec version has a CHANGELOG entry (first section)', () {
      var pubspec = File('pubspec.yaml').readAsStringSync();
      var version = RegExp(
        r'^version:\s*(\S+)',
        multiLine: true,
      ).firstMatch(pubspec)!.group(1);

      var changelog = File('CHANGELOG.md').readAsStringSync();
      var firstSection = RegExp(
        r'^## (\S+)',
        multiLine: true,
      ).firstMatch(changelog)!.group(1);

      expect(firstSection, equals(version));
    });

    test('Bootstrap 5', () {
      expect(bootstrapVersion, startsWith('5.'));
      expect(
        File('pubspec.yaml').readAsStringSync(),
        contains('Adds Bootstrap 5 support'),
      );
    });

    test('bundled Bootstrap matches Bootstrap.VERSION', () {
      var dir = 'lib/bootstrap-$bootstrapVersion';
      expect(
        File('$dir/js/bootstrap.bundle.min.js').readAsStringSync(),
        contains('Bootstrap v$bootstrapVersion '),
      );
      expect(
        File('$dir/js/bootstrap.bundle.js').existsSync(),
        isTrue,
        reason: 'Non-minified bundle (ENABLE_MINIFIED = false)',
      );
      expect(
        File('$dir/css/bootstrap.min.css').readAsStringSync(),
        contains('Bootstrap  v$bootstrapVersion '),
      );
      expect(File('$dir/css/bootstrap.css').existsSync(), isTrue);
    });

    test('bundled JQuery matches JQuery.VERSION', () {
      var dir = 'lib/jquery-$jqueryVersion/js';
      expect(
        File('$dir/jquery.min.js').readAsStringSync(),
        startsWith('/*! jQuery v$jqueryVersion '),
      );
      expect(File('$dir/jquery.js').existsSync(), isTrue);
    });

    test('bundled Moment matches Moment.VERSION', () {
      var dir = 'lib/moment-$momentVersion/js';
      expect(
        File('$dir/moment-with-locales.js').readAsStringSync(),
        contains("hooks.version = '$momentVersion'"),
      );
      expect(
        File('$dir/moment-with-locales.min.js').readAsStringSync(),
        contains('version="$momentVersion"'),
      );
    });

    test('no stale bundled library versions', () {
      List<String> dirs(String prefix) => Directory('lib')
          .listSync()
          .whereType<Directory>()
          .map((d) => d.uri.pathSegments.where((s) => s.isNotEmpty).last)
          .where((n) => n.startsWith(prefix))
          .toList();

      expect(dirs('bootstrap-'), equals(['bootstrap-$bootstrapVersion']));
      expect(dirs('jquery-'), equals(['jquery-$jqueryVersion']));
      expect(dirs('moment-'), equals(['moment-$momentVersion']));
    });

    test('README lists the bundled versions', () {
      var readme = File('README.md').readAsStringSync();
      expect(readme, contains('- Bootstrap: $bootstrapVersion'));
      expect(readme, contains('- Bootstrap Icons: $iconsVersion'));
      expect(readme, contains('- JQuery: $jqueryVersion'));
      expect(readme, contains('- Moment: $momentVersion'));
    });
  });

  group('daterangepicker.js local patches', () {
    final js = File(
      'lib/components/daterangepicker/daterangepicker.js',
    ).readAsStringSync();

    test('documented in the header', () {
      expect(js, contains('Local patches (bones_ui_bootstrap)'));
    });

    test('minute rounded to `timePickerIncrement`', () {
      expect(
        js,
        contains('selectedMinute -= selectedMinute % this.timePickerIncrement'),
      );
      expect(js, contains('if (selectedMinute == i && !disabled)'));
    });

    test('callback with a single array', () {
      expect(
        js,
        contains(
          'this.callback([this.startDate.clone(), this.endDate.clone(), '
          'this.chosenLabel]);',
        ),
      );
    });
  });

  group('Bootstrap 5 markup', () {
    test('no Bootstrap 4 data attributes in the library', () {
      var dart = Directory('lib/src')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .map((f) => f.readAsStringSync())
          .join('\n');

      for (var attr in [
        "'data-toggle'",
        "'data-target'",
        "'data-parent'",
        "'data-dismiss'",
        '"data-toggle',
        '[data-toggle',
      ]) {
        expect(dart, isNot(contains(attr)), reason: attr);
      }
    });
  });
}
