class SearchState<T> {
  final bool isLoading;
  final List<T> results;
  final bool hasError;

  const SearchState({this.isLoading, this.results, this.hasError});

  factory SearchState.initial() => SearchState(
        results: [],
        isLoading: false,
        hasError: false,
      );

  factory SearchState.loading() => SearchState(
        results: [],
        isLoading: true,
        hasError: false,
      );

  factory SearchState.success(List<T> results) => SearchState(
        results: results,
        isLoading: false,
        hasError: false,
      );

  factory SearchState.error() => SearchState(
        results: [],
        isLoading: false,
        hasError: true,
      );
}
