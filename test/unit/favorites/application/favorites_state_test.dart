import 'package:bazzwoo_test/core/domain/failure.dart';
import 'package:bazzwoo_test/home/favorites/application/favorites/favorites_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_data/mock_countries_model.dart';

void main() {
  group('FavoritesState', () {
    test('FavoritesState initial', () {
      expect(
        const FavoritesState.initial(),
        const FavoritesState.initial(),
      );
    });

    test('FavoritesState loading', () {
      expect(
        const FavoritesState.loading(),
        const FavoritesState.loading(),
      );
    });

    test('FavoritesState success', () {
      expect(
        const FavoritesState.success(MockCountriesModel.countries),
        const FavoritesState.success(MockCountriesModel.countries),
      );
    });

    test('FavoritesState failure', () {
      expect(
        const FavoritesState.failure(MockCountriesModel.api),
        const FavoritesState.failure(MockCountriesModel.api),
      );
    });
  });
}
