import 'package:ay_flutter_challenge/utils/extensions/string_operations_extension.dart';

/// A data model class representing the Contact entity.
/// This model contains convenience properties to access
/// the contact's full name, first name's initial, or
/// last name's initial.
class Contact implements Comparable<Contact> {
  String _fullName;
  String _firstName;
  String _lastName;

  /// Constructs a Contact by concatenating the first and last names to
  /// populate the full name.
  Contact({final String firstName, final String lastName})
      : assert(firstName != null),
        assert(lastName != null),
        _firstName = firstName,
        _lastName = lastName,
        _fullName = [firstName, lastName].join(' ');

  /// Constructs a Contact by splitting the full name into first and last names.
  /// The first name is the first word at the provided full name.
  /// The last name is everything that proceeds the first word.
  Contact.fromFullName({String fullName}) : assert(fullName != null) {
    final names = fullName.splitAtFirstWord();
    _firstName = names[0];
    _lastName = names[1];
    _fullName = fullName;
  }

  /// Returns the original full name passed in the constructor or
  /// a concatenation of the first name with the last name.
  String get fullName => _fullName;

  /// Returns the first character of the first name.
  String get firstNameInitial => _firstName[0].toUpperCase();

  /// Returns the first character of the last name.
  String get lastNameInitial => _lastName[0]?.toUpperCase() ?? '';

  @override
  int compareTo(Contact other) => this.fullName.compareTo(other.fullName);

  @override
  String toString() => this.fullName;
}
