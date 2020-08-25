/// A data model class representing a safely parsed input entry.
/// T is the type of the original [value].
class SanitizedEntry<T> {
  final bool isValid;
  final T value;

  const SanitizedEntry({this.isValid, this.value})
      : assert(isValid != null),
        assert(value != null);
}
