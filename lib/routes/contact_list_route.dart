import 'package:ay_flutter_challenge/configs/configs.dart';
import 'package:flutter/material.dart';

import 'contact_detail_route.dart';

class ContactListRoute extends StatelessWidget {
  static const String id = '/contact-list';

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home Route',
                style: theme.textTheme.headline1,
              ),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(ContactDetail.id),
                child: Text('Touch Me!'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
