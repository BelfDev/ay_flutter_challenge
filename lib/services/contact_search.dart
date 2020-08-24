import 'package:ay_flutter_challenge/blocs/search/contact_search_bloc.dart';
import 'package:ay_flutter_challenge/blocs/search/search_state.dart';
import 'package:ay_flutter_challenge/configs/app_theme.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:with_bloc/with_bloc.dart';

class ContactSearch extends SearchDelegate<Contact> {
  final ContactRepository _contactRepository;

  ContactSearch(this._contactRepository);

  List<String> _suggestions = [];
  List<String> _history = [];

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
    _history.add(query);
    return WithBloc<ContactSearchBloc, SearchState<Contact>>(
        createBloc: (context) =>
            ContactSearchBloc(_contactRepository)..searchContacts(query),
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
          _suggestions = contacts.map((contact) => contact.fullName).toList();

          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(
                  contacts[index].fullName,
                  style: styles.texts.sectionTile,
                ),
                onTap: () => close(context, contacts[index]),
              );
            },
            itemCount: state.results.length,
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final styles = Styles.of(context);
    final names = query.isEmpty ? _history : getSuggestions();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.location_city),
        title: Text(
          names[index],
          style: styles.texts.sectionTile,
        ),
      ),
      itemCount: names.length,
    );
  }

  List<String> getSuggestions() {
    if (_suggestions.isNotEmpty) {
      return _suggestions.where((name) => name.startsWith(query)).toList();
    }
    return [];
  }
}
