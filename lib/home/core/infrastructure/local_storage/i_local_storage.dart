import '../../domain/models/country.dart';

/// Describe local storage.
abstract class ILocalStorage {
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
}
