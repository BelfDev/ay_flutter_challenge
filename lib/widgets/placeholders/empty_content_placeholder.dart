import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';

/// A customized [Container] that displays 'empty content' feedback.
class EmptyContentPlaceholder extends StatelessWidget {
  static const String _defaultMessage = 'Nothing was found...';

  const EmptyContentPlaceholder({Key key, this.message = _defaultMessage})
      : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.do_not_disturb_on,
            size: 64,
            color: styles.placeholderIconColor,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: styles.texts.error,
          ),
        ],
      ),
    );
  }
}
