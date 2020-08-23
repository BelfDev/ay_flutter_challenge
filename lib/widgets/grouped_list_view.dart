import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

typedef GroupedListSectionBuilder = Widget Function(
    BuildContext context, int sectionIndex, int index);
typedef GroupedListItemBuilder = Widget Function(
    BuildContext context, int sectionIndex, int itemIndex, int index);

/// A [CustomScrollView] that builds list items grouped by sections.
/// S is the type of the section and T is the type of its items.
/// Supports optional [SliverAppBar], and box [header] or [footer].
/// The [header] is drawn before the list. Conversely, the [footer]
/// is laid out below the list.
/// This widget can also be built inside a [NestedScrollView]. If that is the
/// case, it cannot contain a [SliverAppBar].
class GroupedListView<S extends ExpandableListSection<T>, T>
    extends StatelessWidget {
  const GroupedListView({
    Key key,
    @required this.sectionList,
    @required this.itemBuilder,
    @required this.sectionBuilder,
    this.sliverAppBar,
    this.header,
    this.footer,
    this.nested = false,
  })  : assert(sectionList != null),
        assert(itemBuilder != null),
        assert((sliverAppBar != null || nested) ||
            (sliverAppBar == null && !nested)),
        super(key: key);

  final List<S> sectionList;
  final bool nested;
  final GroupedListItemBuilder itemBuilder;
  final GroupedListSectionBuilder sectionBuilder;
  final Widget sliverAppBar;
  final Widget header;
  final Widget footer;

  bool get _hasSliverAppBar => sliverAppBar != null;

  bool get _hasHeader => header != null;

  bool get _hasFooter => footer != null;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        if (nested) ..._buildNestedScrollSetup(context),
        if (_hasSliverAppBar) sliverAppBar,
        if (_hasHeader) header,
        _buildGroupedList(context),
        if (_hasFooter) footer,
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

  List<Widget> _buildNestedScrollSetup(BuildContext context) => [
        SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
        SliverPersistentHeader(
            pinned: true, floating: true, delegate: _SliverAppBarDelegate())
      ];
}

// TODO: Find an alternative approach to preserve the sticky effect on nested scroll view
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate();

  static const double _size = 100;

  @override
  double get minExtent => _size;

  @override
  double get maxExtent => _size;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: _size,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
