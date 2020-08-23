/// Utility extension which adds convenience operations to the String object.
extension StringOperations on String {
  /// Returns true if this [String] contains non-empty content.
  bool get isNotNullNorEmpty => this != null && this.isNotEmpty;

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
      return [words[0], words.sublist(1)?.join(" ")?.toCapitalCase() ?? ''];
    }
    throw ArgumentError("string is empty: $this");
  }
}
