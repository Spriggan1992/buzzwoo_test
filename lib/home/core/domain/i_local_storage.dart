import 'country.dart';

abstract class ILocalStorage {
  /// Saving [Country] to th local storage.
  Future<void> save(
    Country country,
  );

  /// Delete [Country] from the storage by index.
  Future<void> delete(Country country);

  Future<List<Country>> readAll();
}
