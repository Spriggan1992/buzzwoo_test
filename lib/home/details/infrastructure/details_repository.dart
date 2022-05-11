import 'dart:async';

import '../../../core/infrastructure/utils/make_request.dart';
import '../../core/domain/models/country.dart';
import '../../core/infrastructure/local_storage/i_local_storage.dart';
import '../domain/i_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/domain/failure.dart';

/// Repository for details screen.
@LazySingleton(as: IDetailsRepository)
class DetailsRepository implements IDetailsRepository {
  final ILocalStorage _localStorage;

  DetailsRepository(this._localStorage);

  @override
  Future<Either<Failure, Unit>> addToFavorite(Country country) {
    return makeRequest<Unit>(() async {
      await _localStorage.save(country);

      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> removeFromFavorites(Country country) async {
    return makeRequest<Unit>(() async {
      await _localStorage.delete(country);

      return unit;
    });
  }
}
