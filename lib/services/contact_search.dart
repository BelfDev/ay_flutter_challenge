import 'dart:io';

import 'package:ay_flutter_challenge/blocs/search/search_bloc.dart';
import 'package:ay_flutter_challenge/blocs/search/search_state.dart';
import 'package:ay_flutter_challenge/configs/app_theme.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:ay_flutter_challenge/widgets/separator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:with_bloc/with_bloc.dart';

class ContactSearch extends SearchDelegate<Contact> {
  static const String _hintLabel = "Type in a contact's name";

  final ContactRepository _contactRepository;

  ContactSearch(this._contactRepository) : super();

  @override
  String get searchFieldLabel => _hintLabel;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Theme.of(context).copyWith(
        primaryColor: appTheme.appBarTheme.color,
        primaryIconTheme: appTheme.primaryIconTheme,
        primaryColorBrightness: appTheme.primaryColorBrightness,
        textTheme: appTheme.textTheme);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            icon:
                Icon(Platform.isIOS ? CupertinoIcons.clear_thick : Icons.clear),
            iconSize: 28,
            onPressed: () => query = '',
          )),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back),
        iconSize: 32,
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    final styles = Styles.of(context);
    if (query.isEmpty)
      return Center(
          child: Text('Display History', style: styles.texts.itemTile));

    return WithBloc<SearchBloc, SearchState<Contact>>(
        createBloc: (context) =>
            SearchBloc(_contactRepository)..searchContacts(query),
        builder: (context, bloc, state, _) {
          if (state.isLoading)
            return Center(child: CircularProgressIndicator());

          if (state.hasError)
            return Center(
              child: Text(
                'Has error!',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            );

          if (state.results.isEmpty)
            return Center(
              child: Text(
                'Empty!',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            );

          final List<Contact> contacts = state.results;

          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(
                  contacts[index].fullName,
                  style: styles.texts.itemTile,
                ),
                onTap: () {
                  final contact = contacts[index];
                  bloc.addToContactHistory(contact);
                  close(context, contact);
                },
              );
            },
            itemCount: state.results.length,
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final styles = Styles.of(context);

    return WithBloc<SearchBloc, SearchState<Contact>>(
        createBloc: (context) =>
            SearchBloc(_contactRepository)..getContactSuggestions(query),
        builder: (context, bloc, state, _) {
          final List<Contact> contacts = state.results;
          return ListView.separated(
            separatorBuilder: (_, __) => Separator(),
            itemBuilder: (_, index) => ListTile(
              leading:
                  Icon(query.isEmpty ? Icons.history : Icons.account_circle),
              title: Text(
                contacts[index].fullName,
                style: styles.texts.itemTile,
              ),
              onTap: () {
                final contact = contacts[index];
                bloc.addToContactHistory(contact);
                close(context, contact);
              },
            ),
            itemCount: contacts.length,
          );
        });
  }
}
