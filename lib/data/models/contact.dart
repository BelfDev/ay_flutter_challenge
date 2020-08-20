import 'package:flutter/material.dart';

/// A data model class representing the Contact entity.
/// The model contains convenience properties to access
/// the contact's full name, first name's initial, or
/// last name's initial.
class Contact {
  final String firstName;
  final String lastName;

  const Contact({@required this.firstName, @required this.lastName})
      : assert(firstName != null),
        assert(lastName != null);

  /// Returns a concatenation of the first name with the last name.
  String get fullName => '$firstName $lastName';

  /// Returns the first character of the first name.
  String get firstNameInitial => firstName[0];

  /// Returns the first character of the last name.
  String get lastNameInitial => lastName[0];
}
