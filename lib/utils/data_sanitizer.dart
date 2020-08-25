import 'package:ay_flutter_challenge/data/models/sanitized_entry.dart';

enum _InputIssue { nullEntry, emptyEntry }

/// Utility class that checks for input abnormalities.
/// This class is typically used within data models to
/// help parsing input entries.
class DataSanitizer {
  /// Processes a contact [String] entry and outputs a [SanitizedEntry]
  /// object indicating whether it is valid or not.
  ///
  /// This method checks if the entry is null or empty.
  ///
  /// The original entry value can be retrieved by accessing
  /// the [SanitizedEntry].value property.
  static SanitizedEntry<String> sanitizeContactEntry(String entry) {
    final foundIssues = Set<_InputIssue>();
    // Check if entry is null
    if (entry == null) foundIssues.add(_InputIssue.nullEntry);
    // Check if entry is empty
    if (entry.isEmpty || entry.trim().length == 0)
      foundIssues.add(_InputIssue.emptyEntry);

    final isValid = foundIssues.isEmpty;
    final sanitizedValue = entry.trim();

    return SanitizedEntry<String>(isValid: isValid, value: sanitizedValue);
  }

  DataSanitizer._();
}
