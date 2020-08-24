import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/source/local_data_source.dart';
import 'package:flutter/material.dart';

/// Single source of truth for fetching contact data.
/// The repository may retrieve data from a local or remote data source.
class ContactRepository {
  static const futureDelay = 1000; // milliseconds
  static final ContactRepository _instance = ContactRepository._internal();

  factory ContactRepository() => _instance;

  ContactRepository._internal();

  ContactBook _contactBookCache;

  bool get hasCache => _contactBookCache?.sections?.isNotEmpty ?? false;

  /// Returns a Future<List<Contact>> with all available contacts.
  Future<ContactBook> fetchContacts([bool forceRemote = false]) async {
    try {
      if (forceRemote || _contactBookCache == null) {
        final ContactBook contactBook =
            ContactBook.from(LocalDataSource.contacts);
        _contactBookCache = contactBook;
        return Future.delayed(
            Duration(milliseconds: futureDelay), () => contactBook);
      } else {
        return _contactBookCache;
      }
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }
}
