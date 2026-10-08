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

- Bootstrap: 5.3.7
- Bootstrap Icons: 1.13.1
- JQuery: 3.7.1 (only loaded when needed, e.g. by `BSDateRangePicker`)
- Moment: 2.30.1
- Date Range Picker: 3.1

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

Then load only the Bootstrap JS, so the bundled (non-themed) CSS isn't loaded too:

```dart
Bootstrap.load(loadCss: false);
```

To keep the bundled CSS and only add theme overrides, import just `functions`, `variables`, `variables-dark`,
`maps`, `mixins` and `utilities` (they don't output any CSS) and write the overrides with them.

Note: Bootstrap 5.3 SCSS uses `@import` and global built-in functions, so Dart Sass prints deprecation warnings.

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
[apache_license]: https://www.apache.org/licenses/LICENSE-2.0.txt
