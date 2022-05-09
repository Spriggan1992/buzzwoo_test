import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../core/infrastructure/database/sembast/sembast_database.dart';
import '../domain/country.dart';
import '../domain/i_favorites_repository.dart';
import '../domain/i_local_storage.dart';
import 'dtos/country_dto.dart';

const _favorites = 'favorites';

@LazySingleton(as: IFavoritesRepository)
class FavoritesRepository implements IFavoritesRepository {
  final SembastDatabase _sembastDatabase;
  final ILocalStorage _localStorage;
  final _store = StoreRef.main();

  FavoritesRepository(this._sembastDatabase, this._localStorage);

  @override
  Stream<List<Country>> watchFavoriteCountry() {
    return _store.query().onSnapshots(_sembastDatabase.instance).map(
          (records) => records
              .map((e) => CountryDTO.fromJson(e.value).toDomain())
              .toList(),
        );
  }

  @override
  Future<List<Country>> getFavoritesCountries() async {
    return await _localStorage.readAll();
  }
}
