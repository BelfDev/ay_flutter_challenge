import 'package:flutter/material.dart';

import 'gradient_filter.dart';

/// Custom [SliverAppBar] that expands and contracts according to the
/// scroll position. By default, the bar initiates fully expanded and
/// shrinks upon scrolling.
class FlexibleSliverAppBar extends StatelessWidget {
  final bool innerBoxIsScrolled;
  final String title;
  final String imageSource;

  const FlexibleSliverAppBar(
      {Key key,
      @required this.innerBoxIsScrolled,
      @required this.title,
      this.imageSource})
      : assert(title != null),
        assert(innerBoxIsScrolled != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 200.0,
      forceElevated: innerBoxIsScrolled,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        centerTitle: true,
        title: Text(title),
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
      ),
    );
  }
}
