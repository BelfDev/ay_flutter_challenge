import 'dart:io';

import 'package:ay_flutter_challenge/blocs/blocs.dart';
import 'package:ay_flutter_challenge/blocs/state_status.dart';
import 'package:ay_flutter_challenge/configs/app_localizations.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:ay_flutter_challenge/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:with_bloc/with_bloc.dart';

typedef _ResultTapCallback = Function(Contact contact);

/// Definition of the search page content. This class implements
/// a [SearchDelegate] targeting the 'search for contacts' use-case.
/// [SearchBloc]s are used to access search business logic.
class ContactSearchDelegate extends SearchDelegate<Contact> {
  final BuildContext _context;
  final ContactRepository _contactRepository;

  ContactSearchDelegate(this._context, this._contactRepository) : super();

  @override
  String get searchFieldLabel =>
      AppLocalizations.of(_context).searchRoute.instruction;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final appTheme = Theme.of(context);
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
    return WithBloc<SearchBloc, SearchState<Contact>>(
        createBloc: (context) =>
            SearchBloc(_contactRepository)..searchContacts(query),
        builder: (context, bloc, state, _) {
          switch (state.status) {
            case StateStatus.initial:
            case StateStatus.inProgress:
              return Center(child: CircularProgressIndicator());
            case StateStatus.failure:
              return ErrorPlaceholder();
            default:
              return _ResultsListView(
                isHistory: query.isEmpty,
                results: state.results,
                onTap: (contact) {
                  bloc.addToContactHistory(contact);
                  close(context, contact);
                },
              );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) =>
      WithBloc<SearchBloc, SearchState<Contact>>(
        createBloc: (context) =>
            SearchBloc(_contactRepository)..searchContacts(query),
        inputs: [query],
        builder: (context, bloc, state, _) => _ResultsListView(
          isHistory: query.isEmpty,
          results: state.results,
          onTap: (contact) {
            bloc.addToContactHistory(contact);
            close(context, contact);
          },
        ),
      );
}

/// Customized [ListView] displaying the given results.
/// These results might be a history of contact searches,
/// a list of suggestions or contacts that match the query.
class _ResultsListView extends StatelessWidget {
  const _ResultsListView(
      {Key key, this.results, this.onTap, this.isHistory = false})
      : super(key: key);

  final List<Contact> results;
  final _ResultTapCallback onTap;
  final bool isHistory;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    return ListView.separated(
      separatorBuilder: (_, __) => Separator(),
      itemBuilder: (_, index) => ListTile(
        leading: Icon(
          isHistory ? Icons.history : Icons.account_circle,
          color: styles.searchIconColor,
        ),
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
