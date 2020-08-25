import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';

/// Customized [DecorationBox] that applies an gradient overlay.
/// This widget is often used in conjunction with a [Stack] containing
/// some type of [Image].
class GradientFilter extends StatelessWidget {
  const GradientFilter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(gradient: styles.gradients.appBar),
    );
  }
}
