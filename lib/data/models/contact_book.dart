import 'dart:collection';

import 'contact.dart';

/// A hash-table based implementation of [Map]. This class uses a
/// [LinkedHashMap] to store and manipulate a collection of [Contact]s.
/// The order of insertion is preserved.
class ContactBook {
  final _sectionMap = LinkedHashMap<String, List<Contact>>();

  ContactBook._();

  /// Creates a [ContactBook] instance based on the given list of [Contact]s.
  ContactBook.from(List<Contact> contactEntries) {
    contactEntries
      // Sorts the given contact entries
      ..sort()
      // Populates the _sectionMap by using a common first name initial as key
      ..forEach((entry) {
        final sectionTitle = entry.firstNameInitial;
        if (!_sectionMap.containsKey(sectionTitle)) {
          _sectionMap[sectionTitle] = List<Contact>();
        }
        _sectionMap[sectionTitle].add(entry);
      });
  }

  /// Returns the total number of sections.
  int get sectionCount => _sectionMap.keys.length;

  /// Returns the total number of contacts.
  int get contactCount => _sectionMap.values.length;

  /// Returns a [Map] with section titles and corresponding list of contacts.
  Map<String, List<Contact>> get sectionMap => _sectionMap;

  @override
  String toString() {
    return _sectionMap.entries.map((e) => "${e.key} => ${e.value}").join("\n");
  }
}
