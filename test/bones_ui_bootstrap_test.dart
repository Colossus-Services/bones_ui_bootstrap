@TestOn('browser')
import 'dart:html';

import 'package:bones_ui/bones_ui.dart';
import 'package:bones_ui_bootstrap/bones_ui_bootstrap.dart';
import 'package:test/test.dart';

void main() {
  group('Components', () {
    final rootContainer = DivElement();
    late final MyRoot root;

    setUpAll(() {
      root = MyRoot(rootContainer);
    });

    test('initialize', () async {
      root.initialize();
      await root.onFinishRender.first;

      var myHome = rootContainer.querySelector('#my-home');
      expect(myHome, isA<DivElement>());
    });

    test('BSAccordion', () async {
      var myAccordion = rootContainer.querySelector('#my-accordion');
      expect(myAccordion, isA<DivElement>());
    });
  });
}

class MyRoot extends UIRoot {
  MyRoot(Element? rootContainer) : super(rootContainer);

  @override
  UIComponent? renderContent() => MyHome(content!);
}

class MyHome extends UIComponent {
  MyHome(Element? parent) : super(parent, id: 'my-home');

  @override
  render() => BSAccordion(
      content!,
      [
        AccordionItem('Item A', 'aaa'),
        AccordionItem('Item B', 'bbb'),
      ],
      id: 'my-accordion');
}
