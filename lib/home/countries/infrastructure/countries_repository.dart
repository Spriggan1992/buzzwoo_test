import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/infrastructure/http/api_client.dart';
import '../../../../core/infrastructure/http/endpoints.dart';
import '../../../../core/domain/failure.dart';
import '../../../core/infrastructure/utils/make_request.dart';
import '../../core/domain/models/country.dart';
import '../../core/infrastructure/local_storage/i_local_storage.dart';
import '../../core/infrastructure/dtos/country_dto.dart';
import '../domain/i_country_repository.dart';

/// Defines country repository.
@LazySingleton(as: ICountryRepository)
class CountryRepository implements ICountryRepository {
  final ApiClient _apiClient;
  final ILocalStorage _localStorage;

  CountryRepository(this._apiClient, this._localStorage);
  @override
  Future<Either<Failure, List<Country>>> getCountries(int page) async {
    return _apiClient.get<List<Country>>(
      Endpoints.country,
      queryParameters: {'format': 'json', 'per_page': '10', 'page': page},
      responseParser: (response) async {
        final favorites = await _localStorage.readAll();

        return _parseCountries(response.data, favorites);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> removeFavoriteCountry(Country country) {
    return makeRequest<Unit>(
      () async => await _localStorage.delete(country),
    );
  }
}

List<Country> _parseCountries(
  List<dynamic> responseBody,
  List<Country> favorites,
) {
  final items = responseBody;
  var countries = <Country>[];
  for (var i = 0; i < items.length; i++) {
    if (i != 0) {
      countries = (items[i] as List)
          .map((e) => _getCountry(e as Map<String, dynamic>, favorites))
          .toList();
    }
  }

  return countries;
}

Country _getCountry(
  Map<String, dynamic> json,
  List<Country> favorites,
) {
  final country = CountryDTO.fromJson(json).toDomain();

  return favorites.contains(country)
      ? country.copyWith(isFavorite: true)
      : country.copyWith(isFavorite: false);
}
