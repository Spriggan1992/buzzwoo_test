import 'package:bazzwoo_test/home/favorites/application/favorites/favorites_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock/mock_data/mock_countries_model.dart';
import '../../../mock/mocks/mock_repositories.dart';
import '../../../mock/mocks/mock_services.dart';

void main() {
  late FavoritesBloc _favoritesBloc;
  late MockFavoritesRepository _favoritesRepository;
  late MockFavoritesSubscriptionService _subscriptionService;

  setUp(() {
    _favoritesRepository = MockFavoritesRepository();
    _subscriptionService = MockFavoritesSubscriptionService();
    _favoritesBloc = FavoritesBloc(
      _favoritesRepository,
      _subscriptionService,
    );
  });

  tearDown(() {
    _favoritesBloc.close();
  });

  group(
    'FavoritesBloc',
    () {
      test('initial state is correct', () {
        expect(_favoritesBloc.state, const FavoritesState.initial());
      });

      blocTest<FavoritesBloc, FavoritesState>(
        'emits correct states when favorites started watch successfully',
        setUp: () {
          when(
            () => _favoritesRepository.getFavoritesCountries(),
          ).thenAnswer(
            (_) => Future.value(right(MockCountriesModel.favorites)),
          );
          when(
            () => _subscriptionService.watchFavoriteCountry(),
          ).thenAnswer(
            (_) => Stream.fromIterable([right(MockCountriesModel.favorites)]),
          );
        },
        build: () => _favoritesBloc,
        act: (bloc) => bloc.add(const FavoritesEvent.favoritesStartedWatch()),
        expect: () => [
          const FavoritesState.loading(),
          const FavoritesState.success(MockCountriesModel.favorites),
        ],
      );
      blocTest<FavoritesBloc, FavoritesState>(
        'emits wrong states when favorites started watch unsuccessfully',
        setUp: () {
          when(
            () => _favoritesRepository.getFavoritesCountries(),
          ).thenAnswer(
            (_) => Future.value(left(MockCountriesModel.api)),
          );
          when(
            () => _subscriptionService.watchFavoriteCountry(),
          ).thenAnswer(
            (_) => Stream.fromIterable([left(MockCountriesModel.api)]),
          );
        },
        build: () => _favoritesBloc,
        act: (bloc) => bloc.add(const FavoritesEvent.favoritesStartedWatch()),
        expect: () => [
          const FavoritesState.loading(),
          const FavoritesState.failure(MockCountriesModel.api),
        ],
      );
    },
  );
}
