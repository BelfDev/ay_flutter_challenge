import 'dart:collection';

import 'contact.dart';
import 'section.dart';

/// A custom data structure that contains [Contact]s grouped by [Section]s.
class ContactBook {
  final _sectionMap = LinkedHashMap<String, Section<Contact>>();
  final _sections = List<Section<Contact>>();

  /// TODO: Treat parsing edge cases.
  /// TODO: Treat edge case for weird initials.
  /// Creates a [ContactBook] instance based on the given list of [String] entries.
  /// Complexity: O(n) or O(n^2) for small lists
  ContactBook.from(List<String> entries) {
    final modifiableEntries = List.from(entries);

    modifiableEntries
      // Sorts the given contact entries
      // Dual-Pivot Quicksort algorithm or Insertion Sort (small lists);
      // O(n log(n)) or О(n^2);
      ..sort()
      // Populates the sectionMap and section list by using a common first name initial as key
      // O(n)
      ..forEach((entry) {
        final Contact contact = Contact.fromFullName(fullName: entry);
        final sectionKey = contact.firstNameInitial;

        if (!_sectionMap.containsKey(sectionKey)) {
          final contacts = List<Contact>();
          final section = Section<Contact>(title: sectionKey, items: contacts);
          _sectionMap[sectionKey] = section;
          _sections.add(section);
        }
        // Since the map value points to the same section as the list,
        // we can add an item for both via the reference.
        _sectionMap[sectionKey].addItem(contact);
      });
  }

  ContactBook._();

  /// Returns a [List] of [Sections] containing [Contact] elements.
  List<Section<Contact>> get sections => _sections;

  @override
  String toString() {
    return _sectionMap.entries.map((e) => "${e.key} => ${e.value}").join("\n");
  }
}
