import 'package:ay_flutter_challenge/configs/configs.dart';
import 'package:flutter/material.dart';

/// A [StatelessWidget] which encapsulates the contents of the
/// of the Contact Detail screen.
class ContactDetailRoute extends StatelessWidget {
  static const String id = '/contact-detail';

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'Contact Detail',
            style: theme.textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
