import 'dart:async';

import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:state_queue/state_queue.dart';

import 'contact_state.dart';

class ContactBloc extends StateQueue<ContactState> {
  final ContactRepository _contactRepository;

  ContactBloc(this._contactRepository) : super(ContactState.initial());

  Future<void> requestContactSections(String query) {
    final completer = Completer();

    run((state) async* {
      yield ContactState.loading();

      final ContactBook contactBook = await _contactRepository.fetchContacts();

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
