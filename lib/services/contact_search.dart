import 'dart:io';

import 'package:ay_flutter_challenge/blocs/search/search_bloc.dart';
import 'package:ay_flutter_challenge/blocs/search/search_state.dart';
import 'package:ay_flutter_challenge/configs/app_theme.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:ay_flutter_challenge/widgets/placeholders/empty_content_placeholder.dart';
import 'package:ay_flutter_challenge/widgets/placeholders/error_placeholder.dart';
import 'package:ay_flutter_challenge/widgets/separator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:with_bloc/with_bloc.dart';

typedef _ResultTapCallback = Function(Contact contact);

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

          if (state.hasError) return ErrorPlaceholder();

          if (state.results.isEmpty)
            return EmptyContentPlaceholder(message: 'No contacts were found.');

          return _ResultsListView(
            leadingIcon: Icon(Icons.account_circle),
            results: state.results,
            onTap: (contact) {
              bloc.addToContactHistory(contact);
              close(context, contact);
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) =>
      WithBloc<SearchBloc, SearchState<Contact>>(
        createBloc: (context) =>
            SearchBloc(_contactRepository)..getContactSuggestions(query),
        builder: (context, bloc, state, _) => _ResultsListView(
          leadingIcon:
              Icon(query.isEmpty ? Icons.history : Icons.account_circle),
          results: state.results,
          onTap: (contact) {
            bloc.addToContactHistory(contact);
            close(context, contact);
          },
        ),
      );
}

class _ResultsListView extends StatelessWidget {
  final List<Contact> results;
  final Icon leadingIcon;
  final _ResultTapCallback onTap;

  const _ResultsListView({Key key, this.results, this.leadingIcon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    return ListView.separated(
      separatorBuilder: (_, __) => Separator(),
      itemBuilder: (_, index) => ListTile(
        leading: leadingIcon,
        title: Text(
          results[index].fullName,
          style: styles.texts.itemTile,
        ),
        onTap: () => onTap(results[index]),
      ),
      itemCount: results.length,
    );
  }
}
