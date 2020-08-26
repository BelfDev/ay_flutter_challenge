import 'package:ay_flutter_challenge/configs/app_localizations.dart';
import 'package:ay_flutter_challenge/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A [StatelessWidget] which encapsulates the contents of the
/// of the Contact Detail screen.
class ContactDetailRoute extends StatelessWidget {
  static const String id = '/contact-detail';

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context).settings.arguments;
    final String title = args['title'];

    final theme = AppTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).detailRoute.title),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Center(
              child: Text(
            title,
            style: theme.textTheme.headline1.apply(color: theme.accentColor),
          )),
        ),
      ),
    );
  }
}
