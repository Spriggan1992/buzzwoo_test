import 'package:dartz/dartz.dart';

import '../../../../core/domain/failure.dart';
import '../../core/domain/models/country.dart';

/// Describe country repository.
abstract class ICountryRepository {
  /// Getting countries.
  Future<Either<Failure, List<Country>>> getCountries(int page);

  /// Remove favorite country.
  Future<Either<Failure, Unit>> removeFavoriteCountry(Country country);
}
