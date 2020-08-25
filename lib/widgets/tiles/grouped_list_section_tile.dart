import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';

/// A single fixed-height [ListTile] that displays a title as [Text].
class GroupedListSectionTile extends StatelessWidget {
  static const double _height = 28;
  static const EdgeInsetsGeometry _childPadding =
      const EdgeInsets.only(left: 16);

  const GroupedListSectionTile({Key key, @required this.title})
      : assert(title != null),
        super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    return Container(
      width: double.infinity,
      height: _height,
      decoration: BoxDecoration(gradient: styles.gradients.section),
      child: Padding(
        padding: _childPadding,
        child: Align(
            alignment: Alignment.centerLeft,
            child: SafeArea(
                top: false,
                bottom: false,
                child: Text(title, style: styles.texts.sectionTile))),
      ),
    );
  }
}
