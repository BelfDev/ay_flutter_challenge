import 'package:equatable/equatable.dart';

/// A data model class representing a safely parsed input entry.
/// T is the type of the original [value].
class SanitizedEntry<T> extends Equatable {
  final bool isValid;
  final T value;

  const SanitizedEntry({this.isValid, this.value}) : assert(isValid != null);

  @override
  List<Object> get props => [isValid, value];
}
