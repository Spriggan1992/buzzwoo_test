import 'package:bazzwoo_test/core/domain/failure.dart';
import 'package:bazzwoo_test/home/core/domain/models/country.dart';

import 'mock_income_level.dart';
import 'mock_region_model.dart';

class MockCountriesModel {
  static const Country country = Country(
    id: 'ARG',
    countryCode: 'AR',
    name: 'Argentina',
    region: MockRegionModel.region,
    incomeLevel: MockIncomeLevelModel.incomeLevel,
    capitalCity: 'Buenos Aires',
    longitude: '-58.4173',
    latitude: '-34.6118',
    isFavorite: false,
  );
  static const Country favoritesCountry = Country(
    id: 'ARG',
    countryCode: 'AR',
    name: 'Argentina',
    region: MockRegionModel.region,
    incomeLevel: MockIncomeLevelModel.incomeLevel,
    capitalCity: 'Buenos Aires',
    longitude: '-58.4173',
    latitude: '-34.6118',
    isFavorite: true,
  );

  static const List<Country> countries = [country];
  static const List<Country> favorites = [favoritesCountry];
  static const Failure api = Failure.api();
  static const Failure noConnection = Failure.noConnection();
}
