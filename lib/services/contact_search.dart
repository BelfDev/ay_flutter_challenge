import 'package:ay_flutter_challenge/blocs/search/search_bloc.dart';
import 'package:ay_flutter_challenge/blocs/search/search_state.dart';
import 'package:ay_flutter_challenge/configs/app_theme.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:ay_flutter_challenge/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:with_bloc/with_bloc.dart';

class ContactSearch extends SearchDelegate<Contact> {
  final ContactRepository _contactRepository;

  List<Contact> _suggestions;

  ContactSearch(this._contactRepository) {
    _suggestions = [];
    if (_contactRepository.hasCache) {
      _contactRepository.fetchContacts().then((contactBook) {
        _suggestions = contactBook.contacts;
      });
    }
  }

  List<Contact> get _history =>
      _contactRepository.fetchContactSearchHistory().reversed.toList();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return AppTheme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: BackButtonIcon(),
      onPressed: () {
        close(context, null);
      },
    );
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
                  _addToHistory(contact);
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
    final List<Contact> contacts = query.isEmpty ? _history : getSuggestions();

    return ListView.separated(
      separatorBuilder: (_, __) => Separator(),
      itemBuilder: (_, index) => ListTile(
        leading: Icon(query.isEmpty ? Icons.history : Icons.account_circle),
        title: Text(
          contacts[index].fullName,
          style: styles.texts.itemTile,
        ),
        onTap: () {
          final contact = contacts[index];
          _addToHistory(contact);
          close(context, contact);
        },
      ),
      itemCount: contacts.length,
    );
  }

  List<Contact> getSuggestions() {
    if (_suggestions.isNotEmpty) {
      return _suggestions
          .where((contact) => contact.fullName.contains(query))
          .toList();
    }
    return [];
  }

  void _addToHistory(Contact contact) {
    if (!_history.contains(contact)) {
      _contactRepository.addToSearchHistory(contact);
    }
  }
}
