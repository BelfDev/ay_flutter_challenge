import 'package:flutter/material.dart';

/// A customized [DecorationBox] that applies an gradient overlay.
/// This widget is often used in conjunction with a [Stack] containing
/// some type of [Image].
class GradientFilter extends StatelessWidget {
  const GradientFilter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.0, 0.5),
          end: Alignment(0.0, 0.0),
          colors: <Color>[
            Color(0x60000000),
            Color(0x00000000),
          ],
        ),
      ),
    );
  }
}
