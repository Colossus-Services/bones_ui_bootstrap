import 'package:bones_ui/bones_ui.dart';
import 'package:dom_builder/dom_builder.dart';

/// Accordion item.
class AccordionItem {
  dynamic title;

  dynamic content;

  bool expanded;

  dynamic classes;
  dynamic style;

  dynamic headClasses;
  dynamic headStyle;

  dynamic bodyClasses;
  dynamic bodyStyle;

  AccordionItem(
    this.title,
    this.content, {
    this.expanded = false,
    this.classes,
    this.style,
    this.headClasses,
    this.headStyle,
    this.bodyClasses,
    this.bodyStyle,
  });
}

/// Bootstrap Accordion component.
class BSAccordion extends UIComponent {
  static int _idCounter = 0;

  /// ID of component. Is required by Bootstrap for correct handling of elements.
  @override
  String get id => super.id as String;

  @override
  set id(dynamic id) => super.id = '$id';

  /// Items in accordion.
  final List<AccordionItem> items;

  /// Index of expanded item.
  final int? expandIndex;

  BSAccordion(
    super.parent,
    this.items, {
    String? id,
    this.expandIndex,
    dynamic classes,
    dynamic style,
  }) : super(
         id: _resolveId(id),
         componentClass: 'ui-bs-accordion',
         classes: 'ui-bs-accordion',
         classes2: classes,
         style2: style,
       );

  // Validated before `super`: `UIComponent` resets a blank ID to `null`,
  // which the `id` setter would turn into the string `'null'`.
  static String _resolveId(String? id) {
    if (id == null) return '__BSAccordion__${++_idCounter}';
    if (id.trim().isEmpty) {
      throw ArgumentError('id is required for BSAccordion');
    }
    return id;
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
      expanded =
          itemIndex == expandIndex ||
          (expandIndex! < 0 && itemIndex == items.length + expandIndex!);
    }

    return $div(
      classes: ['card', item.classes],
      style: item.style,
      content: [
        $div(
          id: '$id-heading-$itemIndex',
          classes: ['card-header', item.headClasses],
          style: item.headStyle,
          content: $tag(
            'h2',
            classes: 'mb-0',
            content: $button(
              classes:
                  'd-flex w-100 align-items-center justify-content-between btn btn-link ${expanded ? '' : 'collapsed'}',
              attributes: {
                'data-toggle': 'collapse',
                'data-target': '#$id-collapse-$itemIndex',
                'aria-expanded': '$expanded',
                'aria-controls': '$id-collapse-$itemIndex',
              },
              content: item.title,
            ),
          ),
        ),
        $div(
          id: '$id-collapse-$itemIndex',
          classes: [
            'card-body',
            'collapse ${expanded ? 'show' : ''}',
            item.bodyClasses,
          ],
          style: item.bodyStyle,
          attributes: {
            'aria-labelledby': '$id-heading-$itemIndex',
            'data-parent': '#$id',
          },
          content: item.content,
        ),
      ],
    );
  }
}
