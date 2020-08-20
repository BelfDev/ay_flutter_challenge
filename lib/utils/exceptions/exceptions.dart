/// Custom [Exception] to indicate invalid local data.
class InvalidLocalDataException implements Exception {
  final String message;
  final String data;

  const InvalidLocalDataException(
      {this.message = 'Invalid local data.', this.data});

  @override
  String toString() {
    return '$message\nData:$data';
  }
}
