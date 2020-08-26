import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/utils/exceptions/exceptions.dart';
import 'package:test/test.dart';

void main() {
  List<String> dummyEntries = List<String>();
  final Contact cSantana = Contact.fromFullName('Carlos Santana');
  final Contact mKnopfler = Contact.fromFullName('Mark Knopfler');
  final Contact bbKing = Contact.fromFullName('Riley B. King');

  setUp(() {
    dummyEntries
        .addAll([cSantana.fullName, mKnopfler.fullName, bbKing.fullName]);
  });

  tearDown(() {
    dummyEntries = List<String>();
  });

  group('ContactBook', () {
    test('when constructed from a list of entries should populate sections',
        () {
      final contactBook = ContactBook.from(dummyEntries);

      final expectedSection = [
        Section(title: 'C', items: [cSantana]),
        Section(title: 'M', items: [mKnopfler]),
        Section(title: 'R', items: [bbKing]),
      ];

      expect(contactBook.sections, expectedSection);
    });

    test('when constructed from a list of entries should exclude null values',
        () {
      dummyEntries.add(null);
      final contactBook = ContactBook.from(dummyEntries);

      final expectedSection = [
        Section(title: 'C', items: [cSantana]),
        Section(title: 'M', items: [mKnopfler]),
        Section(title: 'R', items: [bbKing]),
      ];

      expect(contactBook.sections, expectedSection);
    });

    test('when constructed from a list of entries should sort values', () {
      final kRichards = 'Keith Richards';
      dummyEntries.add(kRichards);
      final contactBook = ContactBook.from(dummyEntries);

      final expectedSection = [
        Section(title: 'C', items: [cSantana]),
        Section(title: 'K', items: [Contact.fromFullName(kRichards)]),
        Section(title: 'M', items: [mKnopfler]),
        Section(title: 'R', items: [bbKing]),
      ];

      expect(contactBook.sections, expectedSection);
    });

    test('when constructed from a list of entries should skip invalid entries',
        () {
      final invalidOne = '';
      final invalidTwo = ' ';
      final invalidThree = '    ';
      dummyEntries.addAll([invalidOne, invalidTwo, invalidThree]);
      final contactBook = ContactBook.from(dummyEntries);

      final expectedSection = [
        Section(title: 'C', items: [cSantana]),
        Section(title: 'M', items: [mKnopfler]),
        Section(title: 'R', items: [bbKing]),
      ];

      expect(contactBook.sections, expectedSection);
    });

    test(
        'when constructed from a list of entries should throw error if no valid entries were found',
        () {
      final invalidEntries = [
        null,
        '  ',
        '',
      ];
      try {
        ContactBook.from(invalidEntries);
      } catch (e) {
        expect(e, InvalidDataException<List<String>>(data: invalidEntries));
      }
    });

    test('when constructed from a list of entries should populate contacts',
        () {
      final contactBook = ContactBook.from(dummyEntries);

      final expectedContacts = [cSantana, mKnopfler, bbKing];

      expect(contactBook.contacts, expectedContacts);
    });
  });
}
