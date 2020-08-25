/// Custom [Exception] to indicate invalid local data.
class InvalidDataException<T> implements Exception {
  final String message;
  final T data;

  const InvalidDataException({this.message = 'Invalid local data.', this.data});

  @override
  String toString() {
    return '$message\nData:$data';
  }
}
