import 'dart:html';

import 'package:bones_ui/bones_ui_kit.dart';

/// Accordion item.
class AccordionItem {
  dynamic title;

  dynamic content;

  bool expanded;

  AccordionItem(this.title, this.content, [this.expanded = false]);
}

/// Bootstrap Accordion component.
class BSAccordion extends UIComponent {
  static int _idCounter = 0;

  /// ID of component. Is required by Bootstrap for correct handling of elements.
  @override
  final String id;

  /// Items in accordion.
  final List<AccordionItem> items;

  /// Index of expanded item.
  final int? expandIndex;

  BSAccordion(Element parent, this.items,
      {String? id, this.expandIndex, dynamic classes})
      : id = id ?? '__BSAccordion__${++_idCounter}',
        super(parent, classes: 'ui-bs-accordion', classes2: classes) {
    if (id == null || id.isEmpty) {
      throw ArgumentError('id is required for BSAccordion');
    }
  }

  @override
  void configure() {
    content!.id = id;
  }

  @override
  dynamic render() {
    var renderedItems = [];

    for (var i = 0; i < items.length; ++i) {
      var item = items[i];
      var renderedItem = renderItem(item, i);
      renderedItems.add(renderedItem);
    }

    return renderedItems;
  }

  dynamic renderItem(AccordionItem item, int itemIndex) {
    var expanded = item.expanded;

    if (!expanded && expandIndex != null) {
      expanded = itemIndex == expandIndex ||
          (expandIndex! < 0 && itemIndex == items.length + expandIndex!);
    }

    var itemDiv = $divHTML('''
        <div class="card">
          <div class="card-header" id="$id-heading-$itemIndex">
            <h2 class="mb-0">
              <button class="d-flex w-100 align-items-center justify-content-between btn btn-link ${expanded ? '' : 'collapsed'}" data-toggle="collapse" data-target="#$id-collapse-$itemIndex" aria-expanded="$expanded" aria-controls="$id-collapse-$itemIndex"></button>
            </h2>
          </div>
          <div id="$id-collapse-$itemIndex" class="collapse ${expanded ? 'show' : ''}" aria-labelledby="$id-heading-$itemIndex" data-parent="#$id">
            <div class="card-body"></div>
          </div>
        </div>
    ''')!
      ..select('.btn')!.add(item.title)
      ..select('.card-body')!.add(item.content);

    return itemDiv;
  }
}
