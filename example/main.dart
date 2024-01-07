import 'dart:html';

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
    return MyPage(content);
  }
}

class MyPage extends UIComponent {
  MyPage(super.parent);

  @override
  dynamic render() {
    return [
      $header(content: '''
        <nav class="navbar navbar-dark fixed-top bg-dark">
          <a class="navbar-brand" href="#">
            <ui-svg width="20px" height="20px" src="${BootstrapIcons.getIconPath('app-indicator')}"></ui-svg>
            Fixed navbar
          </a>
        </nav>
      '''),
      $div(classes: 'container', content: [
        '''
        <br>
        <h1 class="mt-5">Welcome</h1>
        This is <b>Bones_UI</b> with <b>Bootstrap</b>!
        <br><br>
      ''',
        '<hr>',
        '<b>BootstrapIcons</b>: &nbsp;',
        BootstrapIcons.allIcons
            .sublist(0, 15)
            .map((name) => BootstrapIcons.svgIconElement(name,
                width: 20, style: 'margin: 2px 4px'))
            .toList(),
        ' ...',
        '<hr>',
        '<b>BSDateRangePicker</b>: &nbsp;',
        BSDateRangePicker(content!),
        '<hr>',
        '<b>BSAccordion</b>: <br>',
        BSAccordion(content!, [
          AccordionItem('A Title', 'A text'),
          AccordionItem('B Title', 'B text'),
          AccordionItem('C Title', 'C text'),
        ]),
      ]),
      $footer(classes: 'footer fixed-bottom', content: [
        $hr,
        $div(
            classes: 'container text-muted pb-2',
            content: 'Copyright © ${DateTime.now().year} Some Example')
      ])
    ];
  }
}

void main() {
  var output = document.querySelector('#output');

  var myUI = MyUI(output);
  myUI.initialize();
}
