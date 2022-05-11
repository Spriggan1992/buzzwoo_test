import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/domain/failure.dart';
import '../../../core/infrastructure/utils/make_request.dart';
import '../../core/domain/models/country.dart';
import '../domain/i_favorites_repository.dart';
import '../../core/infrastructure/local_storage/i_local_storage.dart';

/// Represent favorites repository for [FavoritesScreen]
@LazySingleton(as: IFavoritesRepository)
class FavoritesRepository implements IFavoritesRepository {
  final ILocalStorage _localStorage;

  FavoritesRepository(this._localStorage);

  @override
  Future<Either<Failure, List<Country>>> getFavoritesCountries() async {
    return makeRequest<List<Country>>(
      () async => await _localStorage.readAll(),
    );
  }

  @override
  Future<Either<Failure, Unit>> removeFavoriteCountry(
    Country country,
  ) {
    return makeRequest<Unit>(
      () async {
        await _localStorage.delete(country);

        return unit;
      },
    );
  }
}
