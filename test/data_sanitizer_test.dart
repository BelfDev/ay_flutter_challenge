import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/utils/data_sanitizer.dart';
import 'package:test/test.dart';

void main() {
  group('DataSanitizer', () {
    test('sanitizeContactEntry() checks for null value', () {
      final nullEntry = null;
      final expectedResult = SanitizedEntry<String>(
        isValid: false,
        value: nullEntry,
      );
      SanitizedEntry result = DataSanitizer.sanitizeContactEntry(nullEntry);
      expect(result, expectedResult);
    });

    test('sanitizeContactEntry() checks for empty values', () {
      final emptyEntry = '';
      final expectedResult = SanitizedEntry<String>(
        isValid: false,
        value: emptyEntry,
      );
      SanitizedEntry result = DataSanitizer.sanitizeContactEntry(emptyEntry);
      expect(result, expectedResult);
    });
  });
}
