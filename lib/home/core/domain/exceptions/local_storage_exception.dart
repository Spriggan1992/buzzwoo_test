/// Represent local storage exception.
class LocalStorageException implements Exception {
  /// Error message.
  final String? message;

  LocalStorageException([this.message]);
}
