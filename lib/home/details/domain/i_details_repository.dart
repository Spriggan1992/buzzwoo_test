import 'package:dartz/dartz.dart';

import '../../../core/domain/failure.dart';
import '../../core/domain/country.dart';

abstract class IDetailsRepository {
  /// Adding country to the favorites.
  Future<Either<Failure, Unit>> addToFavorite(Country country);

  /// Removing country from favorites.
  Future<Either<Failure, Unit>> removeFromFavorites(Country country);
}
