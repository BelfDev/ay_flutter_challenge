import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';

/// A customized [Container] that displays 'error' feedback.
class ErrorPlaceholder extends StatelessWidget {
  static const String _defaultMessage = 'Uh-oh! Try again later';

  const ErrorPlaceholder({Key key, this.message = _defaultMessage})
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
            Icons.error,
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
