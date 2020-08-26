import 'package:equatable/equatable.dart';

/// Custom [Exception] to indicate invalid local data.
class InvalidDataException<T> extends Equatable implements Exception {
  final String message;
  final T data;

  const InvalidDataException({this.message = 'Invalid local data.', this.data});

  @override
  String toString() {
    return '$message\nData:$data';
  }

  @override
  List<Object> get props => [message, data];
}
