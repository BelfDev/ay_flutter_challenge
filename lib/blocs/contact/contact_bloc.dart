import 'dart:async';

import 'package:ay_flutter_challenge/blocs/state_status.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:state_queue/state_queue.dart';

part 'contact_state.dart';

/// Business Logic Component for handling contact-related actions.
/// Takes a [ContactRepository] as input.
class ContactBloc extends StateQueue<ContactState> {
  final ContactRepository _contactRepository;

  ContactBloc(this._contactRepository) : super(ContactState.initial());

  /// Emits [SearchState] asynchronously.
  /// [StateStatus].inProgress
  /// [StateStatus].success
  /// [StateStatus].failure
  ///
  /// [StateStatus].success carries a list of fetched [Contact] [Section]s.
  Future<void> requestContactSections() {
    final completer = Completer();

    run((state) async* {
      ContactBook cachedContactBook;
      if (_contactRepository.hasCache) {
        cachedContactBook = await _contactRepository.fetchContacts();
      }

      yield ContactState.loading(cachedContactBook?.sections ?? []);

      final ContactBook contactBook =
          await _contactRepository.fetchContacts(forceRemote: true);

      if (contactBook != null) {
        final List<Section<Contact>> sections = contactBook.sections;
        yield ContactState.success(sections);
      } else {
        yield ContactState.error();
      }

      completer.complete();
    });

    return completer.future;
  }
}
