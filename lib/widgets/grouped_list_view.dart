import 'package:ay_flutter_challenge/mock_data.dart';
import 'package:flutter/material.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

typedef GroupedListSectionBuilder = Widget Function(
    BuildContext context, int sectionIndex, int index);
typedef GroupedListItemBuilder = Widget Function(
    BuildContext context, int sectionIndex, int itemIndex, int index);

// [x] Make this widget generic
/// A [CustomScrollView] that builds list items grouped by sections.
/// S is the type of the section and T is the type of its inner items.
class GroupedListView<S extends ExpandableListSection<T>, T>
    extends StatelessWidget {
  final Widget sliverAppBar;

  // [x] We expect a GroupedListView widget which receives the items
  final List<ExampleSection> sectionList;

  // [x] and be able to work with any data type, given the appropriate builder is provided
  final GroupedListItemBuilder itemBuilder;
  final GroupedListSectionBuilder sectionBuilder;

  const GroupedListView(
      {Key key,
      this.sliverAppBar,
      @required this.sectionList,
      @required this.itemBuilder,
      @required this.sectionBuilder})
      : super(key: key);

  bool get _hasSliverAppBar => sliverAppBar != null;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        if (_hasSliverAppBar) sliverAppBar,
        _buildContactList(),
      ],
    );
  }

  Widget _buildContactList() {
    return SliverExpandableList(
      builder: SliverExpandableChildDelegate<T, S>(
          sectionList: sectionList,
          headerBuilder: sectionBuilder,
          itemBuilder: itemBuilder),
    );
  }
}
