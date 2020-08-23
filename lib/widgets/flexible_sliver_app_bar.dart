import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'gradient_filter.dart';

/// Customized [SliverAppBar] that expands and contracts according to the
/// scroll position. By default, the bar initiates fully expanded and
/// shrinks upon scrolling.
class FlexibleSliverAppBar extends StatelessWidget {
  final String title;
  final String imageSource;

  const FlexibleSliverAppBar({Key key, @required this.title, this.imageSource})
      : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 200.0,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final collapsed = constraints.biggest.height <= kToolbarHeight * 2;
        return FlexibleSpaceBar(
          stretchModes: <StretchMode>[
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
            StretchMode.fadeTitle,
          ],
          title: Text(title),
          titlePadding:
              collapsed ? null : EdgeInsets.only(left: 16, bottom: 16),
          centerTitle: collapsed ? true : false,
          background: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                fit: BoxFit.cover,
              ),
              GradientFilter(),
            ],
          ),
        );
      }),
    );
  }
}
