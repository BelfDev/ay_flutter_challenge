import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'gradient_filter.dart';

/// Customized [SliverAppBar] that expands and contracts according to the
/// scroll position. By default, the bar initiates fully expanded and
/// shrinks upon scrolling.
class FlexibleSliverAppBar extends StatelessWidget {
  const FlexibleSliverAppBar(
      {Key key,
      @required this.title,
      this.imageSource,
      this.forceElevated = false,
      this.searchBar,
      this.expandedHeight})
      : assert(title != null),
        super(key: key);

  final String title;
  final String imageSource;
  final bool forceElevated;
  final Widget searchBar;
  final double expandedHeight;

  bool get _hasSearchBar => searchBar != null;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: expandedHeight,
      forceElevated: forceElevated,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final collapsed = constraints.biggest.height <= kToolbarHeight * 2;
        return FlexibleSpaceBar(
          stretchModes: <StretchMode>[
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
            StretchMode.fadeTitle,
          ],
          collapseMode: CollapseMode.pin,
          title: SafeArea(child: Text(title)),
          titlePadding:
              collapsed ? null : EdgeInsets.only(left: 16, bottom: 72),
          centerTitle: collapsed,
          background: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/icon_pattern.png',
                fit: BoxFit.cover,
              ),
              GradientFilter(),
              if (_hasSearchBar)
                Align(alignment: Alignment.bottomCenter, child: searchBar),
            ],
          ),
        );
      }),
    );
  }
}
