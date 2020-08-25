import 'dart:async';

import 'package:ay_flutter_challenge/blocs/state_status.dart';
import 'package:ay_flutter_challenge/data/models/contact_book.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:state_queue/state_queue.dart';

part 'search_state.dart';

/// Business Logic Component for handling search actions.
/// Takes a [ContactRepository] as input.
class SearchBloc extends StateQueue<SearchState<Contact>> {
  final ContactRepository _contactRepository;

  SearchBloc(this._contactRepository) : super(SearchState.initial());

  /// Emits [SearchState] asynchronously.
  /// [StateStatus].inProgress
  /// [StateStatus].success
  /// [StateStatus].failure
  ///
  /// [StateStatus].success carries a list of resulting contacts.
  /// If the given [query] is empty, these results are the search history.
  /// Otherwise, the results are contacts that match the query pattern.
  Future<void> searchContacts(String query) {
    final completer = Completer();

    run((state) async* {
      yield SearchState.loading();

      List<Contact> results;
      if (query.isEmpty) {
        // If the query is empty, returns the search history
        results = _contactRepository.fetchContactSearchHistory();
      } else if (query.isNotEmpty) {
        // If the query is not empty, returns the matching contacts
        final ContactBook contactBook =
            await _contactRepository.fetchContacts();
        results = contactBook.contacts
            .where((contact) =>
                contact.fullName.toLowerCase().contains(query.toLowerCase()))
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

  /// Adds a contact result to the search history list if it does not
  /// contain it already. Returns true if the operation is successful.
  /// Otherwise, returns false.
  bool addToContactHistory(Contact contact) {
    final history = _contactRepository.fetchContactSearchHistory();
    if (!history.contains(contact)) {
      _contactRepository.addToSearchHistory(contact);
      return true;
    }
    return false;
  }
}
