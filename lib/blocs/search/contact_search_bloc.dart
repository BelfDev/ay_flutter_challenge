import 'dart:async';

import 'package:ay_flutter_challenge/data/models/contact_book.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:state_queue/state_queue.dart';

import 'search_state.dart';

class ContactSearchBloc extends StateQueue<SearchState<Contact>> {
  // TODO: Decide between consuming a cached ContactBook or fetching again through the repository
  final ContactRepository _contactRepository;

  ContactSearchBloc(this._contactRepository)
      :
//        assert(contactRepository != null),
        super(SearchState.initial());

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
}
