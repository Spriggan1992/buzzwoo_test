import 'package:dartz/dartz.dart';

import '../../../core/domain/failure.dart';
import '../../core/domain/country.dart';

abstract class IFavoritesRepository {
  Stream<Either<Failure, List<Country>>> watchFavoriteCountry();
  Future<Either<Failure, List<Country>>> getFavoritesCountries();
  Future<Either<Failure, Unit>> removeFavoriteCountry(Country country);
}
