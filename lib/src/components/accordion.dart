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

  /// ID of the component, also set as the `id` of the accordion element.
  ///
  /// Bootstrap needs it to link each item header to its collapsible body
  /// (`data-bs-target="#<id>-collapse-<index>"`) and to the accordion itself
  /// (`data-bs-parent="#<id>"`). Item elements get the IDs
  /// `<id>-heading-<index>` and `<id>-collapse-<index>`.
  ///
  /// See the `id` parameter of the [BSAccordion] constructor.
  @override
  String get id => super.id as String;

  @override
  set id(dynamic id) => super.id = '$id';

  /// Items in accordion.
  final List<AccordionItem> items;

  /// Index of expanded item.
  final int? expandIndex;

  /// If `true`, renders a Bootstrap "flush" accordion (`accordion-flush`).
  final bool flush;

  /// Creates an accordion with [items] inside [parent].
  ///
  /// The accordion element has the classes `accordion` (required by
  /// Bootstrap 5 for the accordion styles) and `ui-bs-accordion`.
  ///
  /// - [id]: the accordion [id] (see [BSAccordion.id]).
  ///   - `null` (default): a unique ID is generated automatically
  ///     (`__BSAccordion__1`, `__BSAccordion__2`, ...).
  ///   - Non-empty: used as is. Use it when you need a stable ID, for
  ///     example to select the accordion elements in CSS or tests.
  ///   - Empty or blank (e.g. `''`, `'  '`): throws an [ArgumentError].
  ///     Pass `null` (or omit it) to get a generated ID.
  /// - [expandIndex]: index of the item initially expanded. Negative values
  ///   count from the end (`-1` is the last item).
  /// - [flush]: if `true`, adds `accordion-flush`: removes the outer borders
  ///   and rounded corners, keeping the lines between items. Useful when the
  ///   accordion is inside a container that already has its own frame
  ///   (a card, a modal, a sidebar or a full-width list). Default: `false`.
  BSAccordion(
    super.parent,
    this.items, {
    String? id,
    this.expandIndex,
    this.flush = false,
    dynamic classes,
    dynamic style,
  }) : super(
         id: _resolveId(id),
         componentClass: 'ui-bs-accordion',
         classes: [
           'accordion',
           'ui-bs-accordion',
           if (flush) 'accordion-flush',
         ],
         classes2: classes,
         style2: style,
       );

  // Validated before `super`: `UIComponent` resets a blank ID to `null`,
  // which the `id` setter would turn into the string `'null'`.
  static String _resolveId(String? id) {
    if (id == null) return '__BSAccordion__${++_idCounter}';
    if (id.trim().isEmpty) {
      throw ArgumentError.value(
        id,
        'id',
        'BSAccordion `id` cannot be empty or blank. '
            'Pass `null` (or omit `id`) to auto-generate a unique ID, '
            'or pass a non-empty ID (e.g. `id: "my-accordion"`)',
      );
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
      classes: ['accordion-item', item.classes],
      style: item.style,
      content: [
        $tag(
          'h2',
          id: '$id-heading-$itemIndex',
          classes: ['accordion-header', item.headClasses],
          style: item.headStyle,
          content: $button(
            type: 'button',
            classes: ['accordion-button', if (!expanded) 'collapsed'],
            attributes: {
              'data-bs-toggle': 'collapse',
              'data-bs-target': '#$id-collapse-$itemIndex',
              'aria-expanded': '$expanded',
              'aria-controls': '$id-collapse-$itemIndex',
            },
            content: item.title,
          ),
        ),
        $div(
          id: '$id-collapse-$itemIndex',
          classes: ['accordion-collapse', 'collapse', if (expanded) 'show'],
          attributes: {
            'aria-labelledby': '$id-heading-$itemIndex',
            'data-bs-parent': '#$id',
          },
          content: $div(
            classes: ['accordion-body', item.bodyClasses],
            style: item.bodyStyle,
            content: item.content,
          ),
        ),
      ],
    );
  }
}
