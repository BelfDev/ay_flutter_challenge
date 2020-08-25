import 'dart:collection';

import 'package:ay_flutter_challenge/data/models/sanitized_entry.dart';
import 'package:ay_flutter_challenge/utils/data_sanitizer.dart';

import 'contact.dart';
import 'section.dart';

/// A custom data structure that contains [Contact]s grouped by [Section]s.
/// The ContactBook.from named constructor takes care of parsing contacts
/// from a provided list of strings.
class ContactBook {
  final _sectionMap = LinkedHashMap<String, Section<Contact>>();
  final _sections = List<Section<Contact>>();

  /// Creates a [ContactBook] instance based on the given list of [String] entries.
  /// Complexity: O(n) or O(n^2) for small lists
  ///
  /// Adversarial inputs are not included in the [ContactBook].
  ContactBook.from(List<String> entries) {
    final modifiableEntries = List.from(entries);

    modifiableEntries
      // Sorts the given contact entries
      // Dual-Pivot Quicksort algorithm or Insertion Sort (small lists);
      // O(n log(n)) or О(n^2);
      ..sort()
      // Populates the sectionMap and section list by using a common first name initial as key
      // O(n)
      ..forEach((rawEntry) {
        final SanitizedEntry entry =
            DataSanitizer.sanitizeContactEntry(rawEntry);
        if (entry.isValid) {
          final Contact contact = Contact.fromFullName(fullName: entry.value);
          final sectionKey = contact.firstNameInitial;

          if (!_sectionMap.containsKey(sectionKey)) {
            final contacts = List<Contact>();
            final section =
                Section<Contact>(title: sectionKey, items: contacts);
            _sectionMap[sectionKey] = section;
            _sections.add(section);
          }
          // Since the map value points to the same section as the list,
          // we can add an item for both via the reference.
          _sectionMap[sectionKey].addItem(contact);
        }
      });
  }

  ContactBook._();

  /// Returns a [List] of [Sections] containing [Contact] elements.
  List<Section<Contact>> get sections => _sections;

  /// Returns a [List] of all [Contact] values.
  List<Contact> get contacts => _sectionMap.values.fold(List<Contact>(),
      (previousValue, element) => previousValue + element.items);

  @override
  String toString() {
    return _sectionMap.entries.map((e) => "${e.key} => ${e.value}").join("\n");
  }
}
