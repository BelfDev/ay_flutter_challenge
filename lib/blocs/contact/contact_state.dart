part of 'contact_bloc.dart';

/// Defines every possible contact state which
/// is typically emitted by the [ContactBloc].
class ContactState {
  final StateStatus status;
  final List<Section<Contact>> results;

  const ContactState({this.status, this.results});

  factory ContactState.initial() => ContactState(
        status: StateStatus.initial,
        results: [],
      );

  factory ContactState.loading(List<Section<Contact>> sections) => ContactState(
        status: StateStatus.inProgress,
        results: sections,
      );

  factory ContactState.success(List<Section<Contact>> sections) => ContactState(
        status: StateStatus.success,
        results: sections,
      );

  factory ContactState.error() => ContactState(
        status: StateStatus.failure,
        results: [],
      );

  @override
  String toString() {
    return runtimeType.toString();
  }
}
