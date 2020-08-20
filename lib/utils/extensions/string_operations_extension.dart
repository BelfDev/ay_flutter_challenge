/// Utility extension which adds convenience operations to the String object.
extension StringOperations on String {
  /// Returns true if this string contains non-empty content.
  bool get isNotNullNorEmpty => this != null && this.isNotEmpty;
}
