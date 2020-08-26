/// Utility extension which adds convenience operations to the String object.
extension StringOperations on String {
  /// Returns true if this the first character from this [String] is a punctuation character.
  bool get startsWithPunctuation => this.isNotEmpty
      ? this[0].startsWith(RegExp(r'[.!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]'))
      : false;

  /// Returns the [String] with capitalized first character.
  String toCapitalCase() {
    if (this == null) {
      throw ArgumentError("string: $this");
    }

    if (this.isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + this.substring(1);
  }

  /// Returns a [List] with two [String]s. The first element contains the first
  /// word and the second contains the remaining words of the given [String].
  /// Throws [ArgumentError] if the provided [String] is empty.
  List<String> splitAtFirstWord() {
    final words = this.split(' ');
    if (words.isNotEmpty) {
      return [
        words[0].toCapitalCase(),
        words.sublist(1)?.join(" ")?.toCapitalCase() ?? ''
      ];
    }
    throw ArgumentError("string is empty: $this");
  }
}
