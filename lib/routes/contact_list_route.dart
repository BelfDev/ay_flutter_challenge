import 'package:ay_flutter_challenge/configs/app_theme.dart';
import 'package:flutter/material.dart';

class ContactListRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'Home Route',
            style: theme.textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
