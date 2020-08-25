import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:ay_flutter_challenge/widgets/separator.dart';
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
        if (nested) _buildNestedScrollSetup(context),
        if (_hasHeader) header,
        if (_hasSliverAppBar) sliverAppBar,
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
        separatorBuilder: (_, isSectionSeparator, __) => Separator(
          color: isSectionSeparator ? Colors.transparent : styles.dividerColor,
        ),
      ),
    );
  }

  Widget _buildNestedScrollSetup(BuildContext context) {
    final appBarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
    return SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: _SliverAppBarDelegate(appBarHeight: appBarHeight));
  }
}

/// A [SliverPersistentHeaderDelegate] which defines the appearance
/// of the [SliverPersistentHeader]. This delegate is used to prevent
/// the [GroupedListView] content from being drawn behind the outer [SliverAppBar].
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double appBarHeight;

  _SliverAppBarDelegate({@required this.appBarHeight})
      : assert(appBarHeight != null);

  @override
  double get minExtent => appBarHeight;

  @override
  double get maxExtent => appBarHeight;

  @override
  Widget build(_, __, ___) => SizedBox(height: appBarHeight);

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
