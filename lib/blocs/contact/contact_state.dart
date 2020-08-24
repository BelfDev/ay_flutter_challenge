import 'package:ay_flutter_challenge/data/models/contact.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';

class ContactState {
  final bool isLoading;
  final List<Section<Contact>> results;
  final bool hasError;

  const ContactState({this.isLoading, this.results, this.hasError});

  factory ContactState.initial() => ContactState(
        results: [],
        isLoading: false,
        hasError: false,
      );

  factory ContactState.loading() => ContactState(
        results: [],
        isLoading: true,
        hasError: false,
      );

  factory ContactState.success(List<Section<Contact>> sections) => ContactState(
        results: sections,
        isLoading: false,
        hasError: false,
      );

  factory ContactState.error() => ContactState(
        results: [],
        isLoading: false,
        hasError: true,
      );

  @override
  String toString() {
    return runtimeType.toString();
  }
}
