import '../../domain/country.dart';

abstract class ILocalStorage {
  Stream<Country> get subscription;

  /// Saving item to the local storage.
  ///
  /// Throw [LocalStorageException].
  Future<void> save(
    Country country,
  );

  /// Delete item from the storage.
  ///
  /// Throw [LocalStorageException].
  Future<void> delete(Country country);

  /// Getting all items from storage.
  ///
  /// Throw [LocalStorageException].
  Future<List<Country>> readAll();

  Future<void> dispose();
}
