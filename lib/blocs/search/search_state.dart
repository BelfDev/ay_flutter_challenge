part of 'search_bloc.dart';

/// Defines every possible contact state which
/// is typically emitted by the [SearchBloc].
class SearchState<T> {
  final List<T> results;
  final StateStatus status;

  const SearchState({this.status, this.results});

  factory SearchState.initial() => SearchState(
        status: StateStatus.initial,
        results: [],
      );

  factory SearchState.loading() => SearchState(
        status: StateStatus.inProgress,
        results: [],
      );

  factory SearchState.success(List<T> results) => SearchState(
        status: StateStatus.success,
        results: results,
      );

  factory SearchState.error() => SearchState(
        status: StateStatus.failure,
        results: [],
      );

  @override
  String toString() {
    return runtimeType.toString();
  }
}
