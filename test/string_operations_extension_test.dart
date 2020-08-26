import 'package:ay_flutter_challenge/utils/extensions/string_operations_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  tearDown(() {});

  group('StringOperations', () {
    test(
        'startsWithPunctuation returns true if the first character is a punctuation',
        () {
      final punctuations = [
        '.',
        '!',
        '@',
        '#',
        '<',
        '>',
        '?',
        '\"',
        ':',
        '_',
        '`',
        '~',
        '\;',
        '[',
        ']',
        '\\',
        '|',
        '=',
        '+',
        ')',
        '(',
        '*',
        '&',
        '^',
        '%',
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9'
      ];
      punctuations.forEach((punctuation) {
        expect(punctuation.startsWithPunctuation, true);
      });
    });

    test(
        'startsWithPunctuation returns false if the first character is not a punctuation',
        () {
      final nonPunctuations = ['A nice name', 'δε Some greek'];
      nonPunctuations.forEach((punctuation) {
        expect(punctuation.startsWithPunctuation, false);
      });
    });

    test('toCapitalCase() transforms the first character into uppercase', () {
      final example = 'hello world';
      final result = example.toCapitalCase();
      expect(result, 'Hello world');
    });

    test('splitAtFirstWord() returns a list of two substrings', () {
      final example = 'Hello world';
      final result = example.splitAtFirstWord();
      expect(result, ['Hello', 'World']);
    });

    test('splitAtFirstWord() groups substrings after index 0', () {
      final example = 'Hello such a beautiful and nice world';
      final result = example.splitAtFirstWord();
      expect(result, ['Hello', 'Such a beautiful and nice world']);
    });

    test('splitAtFirstWord() capitalizes both substrings', () {
      final example = 'hello world';
      final result = example.splitAtFirstWord();
      expect(result, ['Hello', 'World']);
    });
  });
}
