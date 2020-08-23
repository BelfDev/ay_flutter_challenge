import 'package:ay_flutter_challenge/mock_data.dart';
import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

typedef GroupedListSectionBuilder = Widget Function(
    BuildContext context, int sectionIndex, int index);
typedef GroupedListItemBuilder = Widget Function(
    BuildContext context, int sectionIndex, int itemIndex, int index);

/// A [CustomScrollView] that builds list items grouped by sections.
/// S is the type of the section and T is the type of its inner items.
class GroupedListView<S extends ExpandableListSection<T>, T>
    extends StatelessWidget {
  const GroupedListView({
    Key key,
    @required this.sectionList,
    @required this.itemBuilder,
    @required this.sectionBuilder,
    this.sliverAppBar,
  }) : super(key: key);

  final Widget sliverAppBar;
  final List<ExampleSection> sectionList;
  final GroupedListItemBuilder itemBuilder;
  final GroupedListSectionBuilder sectionBuilder;

  bool get _hasSliverAppBar => sliverAppBar != null;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        if (_hasSliverAppBar) sliverAppBar,
        _buildGroupedList(context),
      ],
    );
  }

  Widget _buildGroupedList(BuildContext context) {
    final styles = Styles.of(context);
    return SliverExpandableList(
      builder: SliverExpandableChildDelegate<T, S>(
          sectionList: sectionList,
          headerBuilder: sectionBuilder,
          itemBuilder: itemBuilder,
          separatorBuilder:
              (BuildContext context, bool isSectionSeparator, int index) {
            return Divider(
              color:
                  isSectionSeparator ? Colors.transparent : styles.dividerColor,
              height: 0,
              thickness: 1,
              indent: 16,
              endIndent: 8,
            );
          }),
    );
  }
}
