import 'package:ay_flutter_challenge/configs/configs.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A [StatelessWidget] which encapsulates the contents of the
/// of the Contact Detail screen.
class ContactDetailRoute extends StatelessWidget {
  static const String id = '/contact-detail';

  final repo = ContactRepository();

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context).settings.arguments;
    final String title = args['title'];

    final theme = AppTheme.of(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Container(
              child: Center(
                  child: Text(
            title,
            style: theme.textTheme.bodyText1,
          ))),
        ),
      ),
    );
  }
}
