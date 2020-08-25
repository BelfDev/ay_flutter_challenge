import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/source/local_data_source.dart';
import 'package:flutter/material.dart';

/// Single source of truth for fetching contact data.
/// The repository may retrieve data from a local or remote data source.
class ContactRepository {
  static const futureDelay = 1500; // milliseconds
  static final ContactRepository _instance = ContactRepository._internal();

  factory ContactRepository() => _instance;

  ContactRepository._internal();

  // In-memory cache for demonstration purposes
  final _searchHistory = List<Contact>();
  ContactBook _contactBookCache;

  bool get hasCache => _contactBookCache?.sections?.isNotEmpty ?? false;

  /// Returns a Future<List<Contact>> with all available contacts.
  /// An in-memory cache is created after the first successful remote fetch.
  /// This cache is returned in subsequent calls to this method.
  /// The [forceRemote] flag can be passed to enforce an asynchronous request.
  Future<ContactBook> fetchContacts({bool forceRemote = false}) async {
    try {
      if (forceRemote || _contactBookCache == null) {
        final ContactBook contactBook =
            ContactBook.from(LocalDataSource.contacts);
        _contactBookCache = contactBook;
        // Simulates an asynchronous request
        return Future.delayed(
            Duration(milliseconds: futureDelay), () => contactBook);
      } else {
        // Returns the cached contact book
        return _contactBookCache;
      }
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  /// Returns an unmodifiable [List] of contacts which were
  /// fetched at some point in the past.
  List<Contact> fetchContactSearchHistory() =>
      List.unmodifiable(_searchHistory);

  /// Adds a contact to the search history list.
  void addToSearchHistory(Contact contact) => _searchHistory.add(contact);
}
