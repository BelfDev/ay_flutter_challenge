import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';

class ErrorPlaceholder extends StatelessWidget {
  static const String _defaultMessage = 'Uh-oh! Try again later';

  final String message;

  const ErrorPlaceholder({Key key, this.message = _defaultMessage})
      : super(key: key);

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
