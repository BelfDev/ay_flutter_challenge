import 'package:ay_flutter_challenge/configs/configs.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:flutter/material.dart';

class GroupedListView extends StatelessWidget {
  final repo = ContactRepository();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
        FutureBuilder<List<Contact>>(
            future: repo.fetchContacts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final contacts = snapshot.data;
                return _buildContactList(contacts, theme);
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                    child: Text('Something went wrong!',
                        style: theme.textTheme.headline1));
              } else {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }), //          SliverPersistentHeader(delegate: MyCustomDelegate())
      ],
    );
  }

  Widget _buildContactList(List<Contact> contacts, ThemeData theme) {
    return SliverFixedExtentList(
      itemExtent: 56.0,
      delegate: SliverChildBuilderDelegate((context, index) {
        return ListTile(
            title: Text(
          '${contacts[index].fullName}',
          style: theme.textTheme.headline1,
        ));
      }, childCount: contacts.length),
    );
  }
}
