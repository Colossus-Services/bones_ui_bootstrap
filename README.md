# Bones_UI Bootstrap

[![pub package](https://img.shields.io/pub/v/bones_ui_bootstrap.svg?logo=dart&logoColor=00b9fc)](https://pub.dartlang.org/packages/bones_ui_bootstrap)
[![Null Safety](https://img.shields.io/badge/null-safety-brightgreen)](https://dart.dev/null-safety)
[![Dart CI](https://github.com/Colossus-Services/bones_ui_bootstrap/actions/workflows/dart.yml/badge.svg?branch=master)](https://github.com/Colossus-Services/bones_ui_bootstrap/actions/workflows/dart.yml)
[![GitHub Tag](https://img.shields.io/github/v/tag/Colossus-Services/bones_ui_bootstrap?logo=git&logoColor=white)](https://github.com/Colossus-Services/bones_ui_bootstrap/releases)
[![New Commits](https://img.shields.io/github/commits-since/Colossus-Services/bones_ui_bootstrap/latest?logo=git&logoColor=white)](https://github.com/Colossus-Services/bones_ui_bootstrap/network)
[![Last Commits](https://img.shields.io/github/last-commit/Colossus-Services/bones_ui_bootstrap?logo=git&logoColor=white)](https://github.com/Colossus-Services/bones_ui_bootstrap/commits/master)
[![Pull Requests](https://img.shields.io/github/issues-pr/Colossus-Services/bones_ui_bootstrap?logo=github&logoColor=white)](https://github.com/Colossus-Services/bones_ui_bootstrap/pulls)
[![Code size](https://img.shields.io/github/languages/code-size/Colossus-Services/bones_ui_bootstrap?logo=github&logoColor=white)](https://github.com/Colossus-Services/bones_ui_bootstrap)
[![License](https://img.shields.io/github/license/Colossus-Services/bones_ui_bootstrap?logo=open-source-initiative&logoColor=green)](https://github.com/Colossus-Services/bones_ui_bootstrap/blob/master/LICENSE)


Adds [Bootstrap 5][bootstrap] to Dart package [Bones_UI][bones_ui], allowing use of Bootstrap components and CSS.

## Embedded JavaScript Libraries 

This package automatically loads (and bundles) the necessaries JavaScript libraries for [Bootstrap][bootstrap].

- Bootstrap: 5.3.8
- Bootstrap Icons: 1.13.1
- JQuery: 3.7.1 (not loaded by this package: only with `JQuery.load()`)
- Moment: 2.30.1
- Date Range Picker: [vanilla-datetimerange-picker][vanilla_datetimerange_picker] (Dan Grossman's
  [daterangepicker][daterangepicker] 3.1 without JQuery), used by `BSDateRangePicker`

NOTE: You don't need to add any HTML or JavaScript code to your project to have full integration of
[Bootstrap][bootstrap] with [Bones_UI][bones_ui].

## Bootstrap 4

Version `5.x` of this package uses Bootstrap 5. For Bootstrap 4 use version `4.x`
(maintained on branch [`4.x`][branch_4x]).

To migrate from `4.x`, see the [CHANGELOG](CHANGELOG.md) (`5.0.0`) and the official
[Bootstrap 5 migration guide][bootstrap_migration].

## Usage

A simple usage example:

```dart
import 'package:bones_ui/bones_ui_kit.dart';
import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';

class MyUI extends UIRoot {
  MyUI(super.rootContainer);

  @override
  void configure() {
    Bootstrap.load();
  }

  @override
  UIComponent renderContent() {
    return MyPage(content) ;
  }

}

class MyPage extends UIComponent {
  MyPage(super.parent);

  @override
  dynamic render() {
    return [
      $header(content: '''
        <nav class="navbar navbar-dark fixed-top bg-dark">
          <a class="navbar-brand" href="#">Fixed navbar</a>
        </nav>
      '''),
      $div(classes: 'container', content: '''
        <br>
        <h1 class="mt-5">Welcome</h1>
        This is <b>Bones_UI</b> with <b>Bootstrap</b>!
      '''),
      $footer(
          classes: 'footer fixed-bottom',
          content: [
            $hr,
            $div(
              classes: 'container text-muted pb-2',
              content: 'Copyright © ${ DateTime.now().year } Some Example')
          ]
      )
    ];
  }
}

void main() {

  var output = document.querySelector('#output');

  var myUI = MyUI( output ) ;
  myUI.initialize() ;

}

```

## BSAccordion

```dart
BSAccordion(parent, [
  AccordionItem('Item A', 'Content A'),
  AccordionItem('Item B', 'Content B'),
], expandIndex: 0);

// Without outer borders and rounded corners (`accordion-flush`):
BSAccordion(parent, items, flush: true);
```

## Custom Bootstrap theme (SCSS)

The Bootstrap SCSS sources are bundled (`lib/bootstrap-5/scss`, the same version as the bundled CSS and JS),
so an app can compile its own themed Bootstrap CSS (e.g. with [sass_builder][sass_builder]):

```scss
// Theme variables, before the import:
$primary: #a2a2a2;
$body-bg: #1b1a16;

@import "package:bones_ui_bootstrap/bootstrap-5/scss/bootstrap";
```

The path has only the major version, so Bootstrap 5.x updates of this package don't change the import.

Then load only the Bootstrap JS, so the bundled (non-themed) CSS isn't loaded too. Set it at the app start, before
any `Bootstrap.load` (including the ones made by this package, e.g. `Bootstrap.enableTooltip`):

```dart
Bootstrap.defaultLoadCss = false;
```

(Or `Bootstrap.load(loadCss: false)`, when it's surely the first `load` call: only the first call loads.)

To keep the bundled CSS and only add theme overrides, import just `functions`, `variables`, `variables-dark`,
`maps`, `mixins` and `utilities` (they don't output any CSS) and write the overrides with them.

Note: Bootstrap 5.3 SCSS uses `@import` and global built-in functions, so Dart Sass prints deprecation warnings.

### Bootstrap 4 compatibility

For apps moving from version `4.x` (Bootstrap 4), `bootstrap-5/bs4-compat` normalizes Bootstrap 5 to look like
Bootstrap 4: import it instead of `bootstrap-5/scss/bootstrap`.

```scss
// Theme variables, before the import:
$primary: #a2a2a2;

@import "package:bones_ui_bootstrap/bootstrap-5/bs4-compat/bootstrap";
```

It's the Bootstrap 5 SCSS between:

- `bs4-compat/_variables.scss`: Bootstrap 4 values for the variables whose defaults changed (border radius, no
  responsive font sizes, links without underline, `<small>`, `<hr>`, `.badge`, `.card`, `.form-control`, `.table`,
  `.navbar`, ...). All `!default`: the app variables set before the import win.
- `bs4-compat/_rules.scss`: Bootstrap 4 styles without a Bootstrap 5 variable: checkboxes and radios without padding,
  date inputs height, lists indent, inherited `.badge`/`.card` colors, `.table` borders, `.navbar-brand`, and the
  accordion (`BSAccordion`) with the look of the Bootstrap 4 `BSAccordion` (each item a `.card`, the header a
  `.card-header`, the button a `.btn-link`).

Accordion items or headers styled by app classes: Bootstrap 5 sets the item radius and border color, and the expanded
button color, with rules more specific than a single class. An item class with its own radius or border color also
sets `--bs-accordion-border-radius`/`--bs-accordion-border-color`, and a header class that colors its contents
(`.x-head * { color: ... }`) also sets `--bs-accordion-btn-color`/`--bs-accordion-active-color`:

```scss
.my-item {
  --bs-accordion-border-radius: 14px;
  border-radius: var(--bs-accordion-border-radius);
}
```

Optionally, the Bootstrap 4 class names (`float-right`, `text-left`, `ml-2`, `font-weight-bold`, `sr-only`,
`badge-pill`, ...), for markup that can't be easily renamed:

```scss
@import "package:bones_ui_bootstrap/bootstrap-5/bs4-compat/bootstrap";
@import "package:bones_ui_bootstrap/bootstrap-5/bs4-compat/class-aliases";
```

## Tooltips

Use the Bootstrap 5 attributes (`data-bs-*`) and enable them with `Bootstrap.enableTooltip()`
(or `Bootstrap.enableTooltipOnRender(component)`):

```html
<button class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-title="Hello">Hover me</button>
```

## Bootstrap Icons

You can use class `BootstrapIcons` to load SVG icons of [Bootstrap Icons][bootstrap_icons].

```dart

  var iconName = 'person-fill' ;
  var iconPath = BootstrapIcons.getIconPath(iconName) ;
  var svg = UISVG(parent, iconPath, width: '1.5em', color: '#0000FF', title: 'User') ;

```


## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Colossus-Services/bones_ui_bootstrap/issues

## Colossus.Services

This is an open-source project from [Colossus.Services][colossus]:
the gateway for smooth solutions.

## Author

Graciliano M. Passos: [gmpassos@GitHub][gmpassos_github].

## See also

Related projects:

- [Bones_UI][bones_ui]: the UI framework this package extends.
- [Bones_API][bones_api]: the server side counterpart of Bones_UI.
- [DOM_Builder][dom_builder] and [DOM_Tools][dom_tools]: DOM construction and utilities used by Bones_UI.
- [Swiss_Knife][swiss_knife]: general utilities (date ranges, events, loaders, ...).
- [Intl_Messages][intl_messages]: internationalization messages.
- [AMDJS][amdjs]: loads the bundled JavaScript libraries.
- [Web_Utils][web_utils]: web (`package:web`) utilities.

Bundled libraries:

- [Bootstrap][bootstrap] and [Bootstrap Icons][bootstrap_icons].
- [vanilla-datetimerange-picker][vanilla_datetimerange_picker], based on Dan Grossman's
  [daterangepicker][daterangepicker].
- [Moment.js][moment] and [jQuery][jquery].

## License

[Apache License - Version 2.0][apache_license]


[gmpassos_github]: https://github.com/gmpassos
[colossus]: https://colossus.services/
[bones_ui]: https://pub.dev/packages/bones_ui
[bootstrap]: https://getbootstrap.com/
[bootstrap_migration]: https://getbootstrap.com/docs/5.3/migration/
[branch_4x]: https://github.com/Colossus-Services/bones_ui_bootstrap/tree/4.x
[bootstrap_icons]: https://icons.getbootstrap.com/
[sass_builder]: https://pub.dev/packages/sass_builder
[bones_api]: https://pub.dev/packages/bones_api
[dom_builder]: https://pub.dev/packages/dom_builder
[dom_tools]: https://pub.dev/packages/dom_tools
[swiss_knife]: https://pub.dev/packages/swiss_knife
[intl_messages]: https://pub.dev/packages/intl_messages
[amdjs]: https://pub.dev/packages/amdjs
[web_utils]: https://pub.dev/packages/web_utils
[vanilla_datetimerange_picker]: https://github.com/alumuko/vanilla-datetimerange-picker
[daterangepicker]: https://www.daterangepicker.com/
[moment]: https://momentjs.com/
[jquery]: https://jquery.com/
[apache_license]: https://www.apache.org/licenses/LICENSE-2.0.txt
