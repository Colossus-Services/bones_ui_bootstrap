import 'dart:html';

import 'package:bones_ui/bones_ui_kit.dart';
import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';

class MyUI extends UIRoot {
  MyUI(Element? rootContainer) : super(rootContainer);

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
  MyPage(Element? parent) : super(parent);

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
