import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/source/local_data_source.dart';
import 'package:ay_flutter_challenge/utils/exceptions/exceptions.dart';
import 'package:ay_flutter_challenge/utils/extensions/string_operations_extension.dart';
import 'package:flutter/cupertino.dart';

/// Single source of truth for fetching contact data.
/// The repository may retrieve data from a local or remote data source.
class ContactRepository {
  static const futureDelay = 400; // milliseconds
  static final ContactRepository _instance = ContactRepository._internal();

  factory ContactRepository() => _instance;

  ContactRepository._internal();

  /// Returns a Future<List<Contact>> with all available contacts.
  Future<List<Contact>> fetchContacts() async {
    try {
      final List<Contact> contacts = LocalDataSource.contacts
          .map((entry) => _parseContact(entry))
          .toList();
      return Future.delayed(
          Duration(milliseconds: futureDelay), () => contacts);
    } catch (e) {
      debugPrint(e);
    }
  }

  Contact _parseContact(String localEntry) {
    // Checks if the local entry contains any value
    if (!localEntry.isNotNullNorEmpty) {
      throw InvalidLocalDataException(data: localEntry);
    }
    // Splits the entry by whitespace character
    List<String> splitStrings = localEntry.split(' ');
    // Returns a parsed contact with first and last name
    return Contact(firstName: splitStrings.first, lastName: splitStrings.last);
  }
}
