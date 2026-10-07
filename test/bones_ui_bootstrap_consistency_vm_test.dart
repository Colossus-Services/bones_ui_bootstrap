@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';

/// Consistency checks between the package files (versions, bundled assets,
/// icons and local patches). Reads the files directly (the library itself
/// can't be imported in the VM).
void main() {
  final base = File('lib/src/bones_ui_bootstrap_base.dart').readAsStringSync();
  final iconsSource = File(
    'lib/src/bones_ui_bootstrap_icons.dart',
  ).readAsStringSync();

  String versionOf(String source, String className) {
    var m = RegExp(
      'class $className \\{.*?VERSION = \'([^\']+)\'',
      dotAll: true,
    ).firstMatch(source);
    if (m == null) throw StateError('$className.VERSION not found');
    return m.group(1)!;
  }

  final bootstrapVersion = versionOf(base, 'Bootstrap');
  final jqueryVersion = versionOf(base, 'JQuery');
  final momentVersion = versionOf(base, 'Moment');
  final iconsVersion = versionOf(iconsSource, 'BootstrapIcons');

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

    test('Bootstrap 4 (4.x line)', () {
      expect(bootstrapVersion, startsWith('4.'));
      var version = RegExp(
        r'^version:\s*(\S+)',
        multiLine: true,
      ).firstMatch(File('pubspec.yaml').readAsStringSync())!.group(1);
      expect(version, startsWith('4.'));
    });

    test('bundled Bootstrap matches Bootstrap.VERSION', () {
      var dir = 'lib/bootstrap-$bootstrapVersion';
      expect(
        File('$dir/js/bootstrap.bundle.min.js').readAsStringSync(),
        contains('Bootstrap v$bootstrapVersion '),
      );
      expect(File('$dir/js/bootstrap.bundle.js').existsSync(), isTrue);
      expect(
        File('$dir/css/bootstrap.min.css').readAsStringSync(),
        contains('Bootstrap v$bootstrapVersion '),
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
      expect(File('$dir/moment-with-locales.min.js').existsSync(), isTrue);
    });

    test('no stale bundled library versions', () {
      // Ignores directories with only hidden files (e.g. `.DS_Store`), left
      // behind by git when switching branches:
      bool hasFiles(Directory d) => d
          .listSync(recursive: true)
          .whereType<File>()
          .any((f) => !f.uri.pathSegments.last.startsWith('.'));

      List<String> dirs(String prefix) => Directory('lib')
          .listSync()
          .whereType<Directory>()
          .where(hasFiles)
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

  group('BootstrapIcons', () {
    test('iconsList matches lib/icons/*.svg', () {
      var match = RegExp(
        r"iconsList = '''(.*?)'''",
        dotAll: true,
      ).firstMatch(iconsSource);
      expect(match, isNotNull, reason: 'iconsList not found');

      var listed = match!
          .group(1)!
          .split(RegExp(r'\s+'))
          .where((s) => s.isNotEmpty)
          .toList();

      expect(
        listed.where((s) => !s.endsWith('.svg')),
        isEmpty,
        reason: 'All entries should be `.svg` files',
      );
      expect(
        listed.toSet().length,
        equals(listed.length),
        reason: 'Duplicates',
      );

      var files = Directory('lib/icons')
          .listSync()
          .whereType<File>()
          .map((f) => f.uri.pathSegments.last)
          .where((n) => n.endsWith('.svg'))
          .toSet();

      expect(
        listed.toSet().difference(files),
        isEmpty,
        reason: 'Listed icons without a file',
      );
      expect(
        files.difference(listed.toSet()),
        isEmpty,
        reason: 'Icon files not listed in iconsList',
      );
    });
  });

  group('daterangepicker.js local patches', () {
    final js = File(
      'lib/components/daterangepicker/daterangepicker.js',
    ).readAsStringSync();

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

  test('no debug prints in BSDateRangePicker', () {
    var source = File(
      'lib/src/components/daterangepicker.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('print(')));
  });
}
