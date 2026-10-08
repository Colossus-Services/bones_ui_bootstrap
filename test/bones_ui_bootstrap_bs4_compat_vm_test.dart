@TestOn('vm')
library;

import 'dart:io';

import 'package:package_config/package_config.dart';
import 'package:sass/sass.dart' as sass;
import 'package:test/test.dart';

/// Compiles the Bootstrap 4 compatibility SCSS (`bootstrap-5/bs4-compat`)
/// through its `package:` URL, as an app theme would import it.
void main() {
  const compatPath = 'package:bones_ui_bootstrap/bootstrap-5/bs4-compat';

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

  /// The declarations of the last rule with exactly [selector] (the
  /// compatibility rules come after the Bootstrap rules with the same
  /// selector).
  String rule(String css, String selector) {
    var matches = RegExp(
      '(^|\\n)${RegExp.escape(selector)} \\{([^}]*)\\}',
    ).allMatches(css);
    if (matches.isEmpty) throw StateError('Rule not found: $selector');
    return matches.last.group(2)!;
  }

  group('Bootstrap 4 compatibility', () {
    late String css;

    setUpAll(() {
      css = compile('@import "$compatPath/bootstrap";');
    });

    test('Bootstrap 5 with the Bootstrap 4 variables', () {
      expect(css, contains('Bootstrap  v5.'));
      expect(css, contains('--bs-border-radius: 0.25rem;'));
      expect(css, contains('--bs-link-decoration: none;'));
      expect(css, contains('--bs-navbar-padding-x: 1rem;'));
      // The keyboard focus keeps the Bootstrap 5 toggler ring:
      expect(css, contains('--bs-navbar-toggler-focus-width: 0.25rem;'));
      expect(css, contains('--bs-card-bg: #fff;'));
      expect(css, contains('--bs-accordion-btn-padding-x: 0.75rem;'));
      expect(css, contains('--bs-accordion-body-padding-y: 1.25rem;'));
      expect(rule(css, 'hr'), contains('opacity: 1;'));
      expect(rule(css, 'small, .small'), contains('font-size: 80%;'));
    });

    test('no responsive font sizes', () {
      expect(rule(css, 'h1, .h1'), contains('font-size: 2.5rem;'));
      expect(css, isNot(contains('calc(1.375rem + 1.5vw)')));
    });

    test('Bootstrap 4 rules', () {
      expect(
        rule(css, 'input[type=checkbox],\ninput[type=radio]'),
        contains('padding: 0;'),
      );
      expect(rule(css, 'ol,\nul'), contains('padding-left: revert;'));
      expect(rule(css, '.form-control'), contains('appearance: auto;'));
      expect(rule(css, '.navbar-brand'), contains('display: inline-block;'));
      expect(
        rule(css, '.navbar-toggler:focus:not(:focus-visible)'),
        contains('box-shadow: none;'),
      );
    });

    test('`.table` borders, except `.table-bordered`/`.table-borderless`', () {
      expect(
        rule(css, '.table > :not(caption) > * > *'),
        contains('border-bottom-width: 0;'),
      );
      // After the rules above (same specificity):
      var table = css.lastIndexOf('.table > thead > * > * {');
      var bordered = css.lastIndexOf(
        '.table-bordered > :not(caption) > * > *,\n'
        '.table-bordered > thead > * > * {',
      );
      var borderless = css.lastIndexOf(
        '.table-borderless > :not(caption) > * > *,\n'
        '.table-borderless > thead > * > * {',
      );
      expect(bordered, greaterThan(table));
      expect(borderless, greaterThan(table));
    });

    test('accordion as the Bootstrap 4 `BSAccordion`', () {
      var item = rule(css, '.accordion-item');
      expect(item, contains('position: relative;'));
      expect(item, contains('flex-direction: column;'));
      expect(
        item,
        contains('border-radius: var(--bs-accordion-border-radius);'),
      );

      // `.accordion-flush` items: no doubled separators:
      expect(
        rule(css, '.accordion-flush > .accordion-item'),
        contains('border-top: 0;'),
      );

      // The `.card-header` (`$card-cap-*`), with the first header top radius:
      var header = rule(css, '.accordion-header');
      expect(header, contains('padding: 0.75rem 1.25rem;'));
      expect(header, contains('background-color: rgba(0, 0, 0, 0.03);'));
      expect(header, contains('font-size: inherit;'));
      expect(
        rule(css, '.accordion-item > .accordion-header:first-child'),
        contains(
          'calc(var(--bs-accordion-border-radius) - '
          'var(--bs-accordion-border-width))',
        ),
      );

      var button = rule(
        css,
        '.accordion-button,\n.accordion-button:not(.collapsed)',
      );
      expect(button, contains('position: static;'));
      expect(button, contains('justify-content: space-between;'));
      expect(button, contains('box-shadow: none;'));
      expect(button, contains('border: 1px solid transparent;'));

      expect(rule(css, '.accordion-button::after'), contains('display: none;'));

      // `.btn-link` hover/focus:
      expect(
        rule(css, '.accordion-button:hover'),
        contains('color: var(--bs-link-hover-color);'),
      );
      expect(
        rule(css, '.accordion-button:hover,\n.accordion-button:focus'),
        contains('text-decoration: underline;'),
      );
    });

    test('the rules come after the Bootstrap rules they override', () {
      var bootstrapButton = css.indexOf(
        'box-shadow: inset 0 calc(-1 * var(--bs-accordion-border-width))',
      );
      var compatButton = css.indexOf(
        '.accordion-button,\n.accordion-button:not(.collapsed) {',
      );
      expect(bootstrapButton, greaterThan(0));
      expect(compatButton, greaterThan(bootstrapButton));

      var bootstrapReboot = css.indexOf('\nol,\nul {\n  padding-left: 2rem;');
      var compatList = css.indexOf('\nol,\nul {\n  padding-left: revert;');
      expect(bootstrapReboot, greaterThan(0));
      expect(compatList, greaterThan(bootstrapReboot));
    });
  });

  test('app variables override the compatibility variables', () {
    var css = compile('''
      \$primary: #a2a2a2;
      \$body-color: #343434;
      \$border-radius: 1rem;
      \$link-decoration: underline;
      @import "$compatPath/bootstrap";
    ''');

    expect(css, contains('--bs-primary: #a2a2a2;'));
    expect(css, contains('--bs-border-radius: 1rem;'));
    expect(css, contains('--bs-link-decoration: underline;'));
    // `$table-color` follows the app `$body-color`:
    expect(css, contains('--bs-table-color: #343434;'));
  });

  test('app `\$prefix`', () {
    var css = compile('''
      \$prefix: "x-";
      @import "$compatPath/bootstrap";
    ''');

    expect(css, contains('--x-accordion-btn-color: var(--x-link-color);'));
    expect(css, contains('--x-accordion-active-color: var(--x-link-color);'));
    expect(css, isNot(contains('var(--bs-')));
  });

  test('variables only: no CSS output', () {
    var css = compile('@import "$compatPath/variables";');
    expect(css.trim(), isEmpty);
  });

  test('class aliases', () {
    var css = compile('''
      @import "$compatPath/bootstrap";
      @import "$compatPath/class-aliases";
    ''');

    // `.bs5` and then `.bs4` in the same selector list (indented inside
    // `@media`, possibly over several lines):
    bool aliased(String bs5, String bs4) => RegExp(
      '(^|[\\s,])\\.${RegExp.escape(bs5)},([^{]*,)?\\s*'
      '\\.${RegExp.escape(bs4)}[\\s,{]',
    ).hasMatch(css);

    expect(aliased('float-end', 'float-right'), isTrue);
    expect(aliased('float-md-start', 'float-md-left'), isTrue);
    expect(aliased('text-end', 'text-right'), isTrue);
    expect(aliased('ms-2', 'ml-2'), isTrue);
    expect(aliased('me-auto', 'mr-auto'), isTrue);
    expect(aliased('pe-lg-3', 'pr-lg-3'), isTrue);
    expect(aliased('fw-bold', 'font-weight-bold'), isTrue);
    expect(aliased('fst-italic', 'font-italic'), isTrue);
    // A skip link (`sr-only sr-only-focusable`) only hidden while not focused:
    expect(
      aliased('visually-hidden', 'sr-only:not(.sr-only-focusable)'),
      isTrue,
    );
    expect(
      aliased(
        'visually-hidden-focusable:not(:focus):not(:focus-within)',
        'sr-only-focusable:not(:focus):not(:focus-within)',
      ),
      isTrue,
    );
    expect(aliased('rounded-pill', 'badge-pill'), isTrue);
    expect(aliased('text-bg-primary', 'badge-primary'), isTrue);
    expect(rule(css, '.form-group'), contains('margin-bottom: 1rem;'));
  });
}
