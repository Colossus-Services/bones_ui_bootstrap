@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';

/// Checks that `BootstrapIcons.iconsList` matches the icons in `lib/icons/`.
///
/// It reads the source file (the library itself can't be imported in the VM).
void main() {
  test('BootstrapIcons.iconsList matches lib/icons/*.svg', () {
    var source = File(
      'lib/src/bones_ui_bootstrap_icons.dart',
    ).readAsStringSync();

    var match = RegExp(
      r"iconsList = '''(.*?)'''",
      dotAll: true,
    ).firstMatch(source);
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
    expect(listed.toSet().length, equals(listed.length), reason: 'Duplicates');

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

  test('BootstrapIcons.VERSION matches the bundled icons', () {
    var source = File(
      'lib/src/bones_ui_bootstrap_icons.dart',
    ).readAsStringSync();
    var css = File('lib/icons/bootstrap-icons.css').readAsStringSync();

    var version = RegExp(r"VERSION = '([^']+)'").firstMatch(source)!.group(1);
    expect(css, contains('Bootstrap Icons v$version'));
  });
}
