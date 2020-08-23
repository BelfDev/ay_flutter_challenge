import 'package:ay_flutter_challenge/blocs/search/contact_search_bloc.dart';
import 'package:ay_flutter_challenge/blocs/search/search_state.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:with_bloc/with_bloc.dart';

//class ContactSearch extends SearchDelegate<Contact> {
//  final ContactSearchBloc bloc;
//  SearchState<Contact> state;
//
//  // TODO: Add bloc not nullable assertion.
//  ContactSearch({this.bloc, this.state});
//
//  @override
//  List<Widget> buildActions(BuildContext context) {
//    return [
//      IconButton(
//        icon: Icon(Icons.clear),
//        onPressed: () {
//          query = '';
//        },
//      ),
//    ];
//  }
//
//  @override
//  Widget buildLeading(BuildContext context) {
//    return IconButton(
//      icon: BackButtonIcon(),
//      onPressed: () {
//        close(context, null);
//      },
//    );
//  }
//
//  @override
//  Widget buildResults(BuildContext context) {
//    bloc.searchContacts(query);
//    final styles = Styles.of(context);
//
//    if (state.isLoading) return Center(child: CircularProgressIndicator());
//
//    if (state.hasError)
//      return Center(child: Text('Error!', style: styles.texts.sectionTile));
//
//    return ListView.builder(
//      itemBuilder: (context, index) {
//        final List<Contact> contacts = state.results;
//
//        return ListTile(
//          leading: Icon(Icons.account_circle),
//          title: Text(
//            contacts[index].fullName,
//            style: styles.texts.sectionTile,
//          ),
//          onTap: () => close(context, contacts[index]),
//        );
//      },
//      itemCount: state.results.length,
//    );
//  }
//
//  @override
//  Widget buildSuggestions(BuildContext context) {
//    final styles = Styles.of(context);
//    return Text(query, style: styles.texts.sectionTile);
//  }
//}

class ContactSearch extends SearchDelegate<Contact> {
  final ContactSearchBloc _contactSearchBloc;
  final ContactRepository _contactRepository;

  ContactSearch(this._contactSearchBloc, this._contactRepository);

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
    _contactSearchBloc.searchContacts(query);

    return WithBloc<ContactSearchBloc, SearchState<Contact>>(
        createBloc: (context) => ContactSearchBloc(_contactRepository),
        child: Center(
            child: Text('I AM A CHILD', style: styles.texts.sectionTile)),
        builder: (context, bloc, state, _) {
          print('RESULTS LENGTH: ${state.results.length}');

          if (state.isLoading)
            return Center(child: CircularProgressIndicator());

          if (state.hasError)
            return Center(
                child: Text('Error!', style: styles.texts.sectionTile));

          if (state.results.isNotEmpty)
            return ListView.builder(
              itemBuilder: (context, index) {
                final List<Contact> contacts = state.results;

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

          return Center(child: Text('Empty', style: styles.texts.sectionTile));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final styles = Styles.of(context);
    return ListTile(
      leading: Icon(Icons.account_circle),
      title: Text(
        query,
        style: styles.texts.sectionTile,
      ),
    );
  }
}
