import 'package:ay_flutter_challenge/data/models/contact.dart';
import 'package:test/test.dart';

void main() {
  group('Contact', () {
    test('when constructed with first and last name should generate full name',
        () {
      final Contact contact = Contact(firstName: 'Joe', lastName: 'Doe');

      final fullName = contact.fullName;

      expect(fullName, 'Joe Doe');
    });

    test(
        'when constructed with full names should infer first and last name initials',
        () {
      final Contact contact = Contact.fromFullName(fullName: 'Joe Doe');

      expect(contact.firstNameInitial, 'J');
      expect(contact.lastNameInitial, 'D');
    });

    test(
        'when constructed with large full names should consider the last name as everything after the first word',
        () {
      final Contact contact = Contact.fromFullName(
          fullName: 'Joe Doe da Silva Pinto Churchill Baggins Bond II');

      expect(contact.firstNameInitial, 'J');
      expect(contact.lastNameInitial, 'D');
    });
  });
}
