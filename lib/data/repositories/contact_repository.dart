import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/source/local_data_source.dart';
import 'package:flutter/cupertino.dart';

/// Single source of truth for fetching contact data.
/// The repository may retrieve data from a local or remote data source.
class ContactRepository {
  static const futureDelay = 400; // milliseconds
  static final ContactRepository _instance = ContactRepository._internal();

  factory ContactRepository() => _instance;

  ContactRepository._internal();

  /// Returns a Future<List<Contact>> with all available contacts.
  Future<ContactBook> fetchContacts() async {
    try {
      final ContactBook contactBook =
          ContactBook.from(LocalDataSource.contacts);

      return Future.delayed(
          Duration(milliseconds: futureDelay), () => contactBook);
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }
}
