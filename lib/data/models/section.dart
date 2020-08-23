import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

/// A data model class representing the Section entity.
/// E corresponds to the type of the [List] [items] contained in the section.
/// [items] cannot be null.
class Section<E> implements ExpandableListSection<E> {
  final List<E> items;

  const Section({this.items}) : assert(items != null);

  /// Adds [item] to the end of this list,
  /// extending the length by one.
  void addItem(E item) => items.add(item);

  @override
  List<E> getItems() => items;

  @override
  bool isSectionExpanded() => false;

  @override
  void setSectionExpanded(bool expanded) => false;

  @override
  String toString() {
    return items.join(' | ');
  }
}
