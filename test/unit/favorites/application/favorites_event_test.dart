import 'package:bazzwoo_test/home/favorites/application/favorites/favorites_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_data/mock_countries_model.dart';

void main() {
  group(
    'FavoritesEvent',
    () {
      test(
        'FavoritesStartedWatchEvent',
        () {
          expect(
            const FavoritesEvent.favoritesStartedWatch(),
            const FavoritesEvent.favoritesStartedWatch(),
          );
        },
      );
      test(
        'FavoritesCountriesReceivedEvent',
        () {
          expect(
            FavoritesEvent.countriesReceived(
              right(
                MockCountriesModel.countries,
              ),
            ),
            FavoritesEvent.countriesReceived(
              right(
                MockCountriesModel.countries,
              ),
            ),
          );
        },
      );
      test(
        'FavoriteCountryRemovedEvent',
        () {
          expect(
            const FavoritesEvent.favoriteCountryRemoved(
              MockCountriesModel.country,
            ),
            const FavoritesEvent.favoriteCountryRemoved(
              MockCountriesModel.country,
            ),
          );
        },
      );
    },
  );
}
