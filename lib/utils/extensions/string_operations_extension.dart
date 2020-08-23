/// Utility extension which adds convenience operations to the String object.
extension StringOperations on String {
  /// Returns true if this string contains non-empty content.
  bool get isNotNullNorEmpty => this != null && this.isNotEmpty;

  /// Returns the String with capitalized first character.
  String toCapitalCase() {
    if (this == null) {
      throw ArgumentError("string: $this");
    }

    if (this.isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + this.substring(1);
  }
}
