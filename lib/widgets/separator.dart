import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';

/// Custom [Divider] typically used to separate [ListTile]s.
class Separator extends StatelessWidget {
  final Color color;

  const Separator({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Styles.of(context).dividerColor,
      height: 0,
      thickness: 1,
      indent: 16,
      endIndent: 8,
    );
  }
}
