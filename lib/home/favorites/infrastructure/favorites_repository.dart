import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../core/domain/failure.dart';
import '../../../core/infrastructure/database/sembast/sembast_database.dart';
import '../../../core/infrastructure/utils/make_request.dart';
import '../../core/domain/country.dart';
import '../domain/i_favorites_repository.dart';
import '../../core/infrastructure/local_storage/i_local_storage.dart';
import '../../core/infrastructure/dtos/country_dto.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IFavoritesRepository)
class FavoritesRepository implements IFavoritesRepository {
  final SembastDatabase _sembastDatabase;
  final ILocalStorage _localStorage;
  final _store = StoreRef.main();

  FavoritesRepository(this._sembastDatabase, this._localStorage);

  @override
  Stream<Either<Failure, List<Country>>> watchFavoriteCountry() async* {
    yield* _store.query().onSnapshots(_sembastDatabase.instance).map(
      (records) {
        final countries = records
            .map((e) => CountryDTO.fromJson(e.value).toDomain())
            .toList();

        return right(countries);
      },
    )..onErrorReturnWith((_, __) => left(const Failure.api()));
  }

  @override
  Future<Either<Failure, List<Country>>> getFavoritesCountries() async {
    return makeRequest<List<Country>>(
      () async => await _localStorage.readAll(),
    );
  }

  @override
  Future<Either<Failure, Unit>> removeFavoriteCountry(Country country) {
    return makeRequest<Unit>(
      () async {
        await _localStorage.readAll();

        return unit;
      },
    );
  }
}
