import 'package:ay_flutter_challenge/configs/configs.dart';
import 'package:ay_flutter_challenge/data/models/contact.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:flutter/material.dart';

/// A [StatelessWidget] which encapsulates the contents of the
/// of the Contact Detail screen.
class ContactDetailRoute extends StatelessWidget {
  static const String id = '/contact-detail';

  final repo = ContactRepository();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
              child: FutureBuilder(
            future: repo.fetchContacts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Contact> contacts = snapshot.data;
                return ListView.builder(
                    itemCount: contacts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Center(
                          child: Text(
                            contacts[index].fullName,
                            style: theme.textTheme.headline1,
                          ),
                        ));
              } else if (snapshot.hasError) {
                return SizedBox(
                  child: Text('Error'),
                  width: 60,
                  height: 60,
                );
              } else {
                return SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                );
              }
            },
          )),
        ),
      ),
    );
  }
}
