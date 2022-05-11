import 'package:dartz/dartz.dart';

import '../../../core/domain/failure.dart';
import '../../core/domain/models/country.dart';

/// Describe favorite repository for [FavoritesScreen].
abstract class IFavoritesRepository {
  /// Getting favorite countries.
  Future<Either<Failure, List<Country>>> getFavoritesCountries();

  /// Removing favorite country.
  Future<Either<Failure, Unit>> removeFavoriteCountry(
    Country country,
  );
}
