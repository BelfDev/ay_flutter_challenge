import 'package:ay_flutter_challenge/data/models/sanitized_entry.dart';

enum _InputIssue { nullEntry, emptyEntry }
enum _InputWarning { nonLetterInitial }

/// Utility class that checks for input abnormalities.
/// This class is typically used within data models to
/// help parsing input entries.
class DataSanitizer {
  static final _onlyLetters = RegExp(r'\p{L}');

  /// Processes a contact [String] entry and outputs a [SanitizedEntry]
  /// object indicating whether it is valid or not.
  ///
  /// This method checks if the entry is null, empty, or starts with
  /// characters that are not necessarily letters.
  ///
  /// The original entry value can be retrieved by accessing
  /// the [SanitizedEntry].value property.
  static SanitizedEntry<String> sanitizeContactEntry(String entry) {
    final foundIssues = Set<_InputIssue>();
    final foundWarnings = Set<_InputWarning>();
    // Check if entry is null
    if (entry == null) foundIssues.add(_InputIssue.nullEntry);
    // Check if entry is empty
    if (entry.isEmpty) foundIssues.add(_InputIssue.emptyEntry);
    // Check if entry does not start with a letter
    if (!entry[1].contains(_onlyLetters))
      foundWarnings.add(_InputWarning.nonLetterInitial);

    final isValid = foundIssues.isEmpty;
    // Inserts a '#' at the beginning of the entry in case it does not start with letters
    final sanitizedValue =
        foundWarnings.contains(_InputWarning.nonLetterInitial)
            ? '#' + entry
            : entry;

    return SanitizedEntry<String>(isValid: isValid, value: sanitizedValue);
  }

  DataSanitizer._();
}
