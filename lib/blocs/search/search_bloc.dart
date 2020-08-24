import 'dart:async';

import 'package:ay_flutter_challenge/data/models/contact_book.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:state_queue/state_queue.dart';

import 'search_state.dart';

class SearchBloc extends StateQueue<SearchState<Contact>> {
  final ContactRepository _contactRepository;

  SearchBloc(this._contactRepository) : super(SearchState.initial());

  Future<void> searchContacts(String query) {
    final completer = Completer();

    run((state) async* {
      yield SearchState.loading();

      final ContactBook contactBook = await _contactRepository.fetchContacts();

      if (contactBook != null) {
        final List<Contact> contacts = contactBook.contacts;
        final List<Contact> results = contacts
            .where((contact) => contact.fullName.contains(query))
            .toList();
        yield SearchState.success(results);
      } else {
        yield SearchState.error();
      }

      completer.complete();
    });

    return completer.future;
  }

  Future<void> getContactSuggestions(String query) {
    final completer = Completer();

    run((state) async* {
      yield SearchState.loading();

      List<Contact> results;
      if (query.isEmpty) {
        results = _contactRepository.fetchContactSearchHistory();
      } else {
        final contacts = (await _contactRepository.fetchContacts()).contacts;
        results = contacts
            .where((contact) => contact.fullName.contains(query))
            .toList();
      }

      if (results != null) {
        yield SearchState.success(results);
      } else {
        yield SearchState.error();
      }

      completer.complete();
    });

    return completer.future;
  }

  bool addToContactHistory(Contact contact) {
    final history = _contactRepository.fetchContactSearchHistory();
    if (!history.contains(contact)) {
      _contactRepository.addToSearchHistory(contact);
      return true;
    }
    return false;
  }
}
