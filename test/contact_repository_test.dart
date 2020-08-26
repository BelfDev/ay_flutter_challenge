import 'package:ay_flutter_challenge/data/models/contact_book.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:ay_flutter_challenge/data/source/local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ContactRepository contactRepository;
  // In a real local data source we would mock this property
  List<String> mockEntries = LocalDataSource.contacts;

  setUp(() {
    contactRepository = ContactRepository();
  });

  tearDown(() {
    contactRepository = null;
  });

  group('ContactRepository', () {
    test('.fetchContacts() should return contact book from local data source',
        () async {
      final expectedResult = ContactBook.from(mockEntries);
      final results = await contactRepository.fetchContacts();
      expect(results, expectedResult);
    });

    test('hasCache should should indicate populated cache', () async {
      await contactRepository.fetchContacts();
      final hasCache = contactRepository.hasCache;
      expect(hasCache, true);
    });

    test('hasCache should should indicate unpopulated cache', () async {
      final hasCache = contactRepository.hasCache;
      expect(hasCache, false);
    });

    test(
        '.addToSearchHistory() should add a new contact to the search history list',
        () async {
      final gandalf = Contact.fromFullName('Gandalf');
      final galadriel = Contact.fromFullName('Galadriel');

      contactRepository.addToSearchHistory(gandalf);
      contactRepository.addToSearchHistory(galadriel);

      final history = contactRepository.fetchContactSearchHistory();
      expect(history, [gandalf, galadriel]);
    });
  });
}
