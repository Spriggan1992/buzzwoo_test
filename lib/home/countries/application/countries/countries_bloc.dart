import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/failure.dart';
import '../../../core/domain/i_local_storage_subscriptions.dart';
import '../../../core/domain/models/country.dart';
import '../../../core/infrastructure/local_storage/i_local_storage.dart';
import '../../core/loading_state.dart';
import '../../domain/i_country_repository.dart';

part 'countries_event.dart';
part 'countries_state.dart';
part 'countries_bloc.freezed.dart';

@injectable
class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final ICountryRepository _countryRepository;
  final ILocalStorage _localStorage;
  final IFavoriteSubscriptionService _favoriteSubscriptionService;
  StreamSubscription? _subscription;
  CountriesBloc(
    this._countryRepository,
    this._localStorage,
    this._favoriteSubscriptionService,
  ) : super(CountriesState.initial()) {
    on<CountriesEvent>(
      (event, emit) async {
        await event.map(
          countriesLoaded: (e) async {
            emit(state.copyWith(loadingState: const LoadingState.loading()));
            final response = await _countryRepository.getCountries(1);
            emit(
              response.fold(
                (failure) =>
                    state.copyWith(loadingState: LoadingState.failure(failure)),
                (countries) => state.copyWith(
                  countries: countries,
                  loadingState: const LoadingState.success(),
                ),
              ),
            );
            add(const CountriesEvent.favoritesStartedWatch());
          },
          favoritesStartedWatch: (e) async {
            _subscription = null;
            _subscription = _favoriteSubscriptionService
                .watchFavoriteCountry()
                .listen((countriesOrFailure) {
              add(CountriesEvent.favoriteCountriesReceived(countriesOrFailure));
            });
          },
          favoriteCountriesReceived: (e) async {
            e.countriesOrFailure.fold(
              (failure) => emit(
                state.copyWith(
                  loadingState: LoadingState.failure(failure),
                ),
              ),
              (favorites) {
                final countries = state.countries.map(
                  (country) {
                    Country? updatedCountry;
                    updatedCountry =
                        favorites.map((e) => e.id).contains(country.id)
                            ? country.copyWith(isFavorite: true)
                            : country.copyWith(isFavorite: false);

                    return updatedCountry;
                  },
                ).toList();

                emit(state.copyWith(countries: countries));
              },
            );
          },
          nextItemsLoaded: (e) async {
            emit(
              state.copyWith(
                availableToLoad: false,
              ),
            );
            await Future.delayed(const Duration(milliseconds: 500));
            final response =
                await _countryRepository.getCountries(state.page + 1);
            emit(
              response.fold(
                (failure) => state.copyWith(
                  loadingState: LoadingState.failure(failure),
                  availableToLoad: true,
                ),
                (countries) => state.copyWith(
                  countries: [...state.countries, ...countries],
                  page: state.page + 1,
                  availableToLoad: true,
                ),
              ),
            );
          },
          favoriteCountryRemoved: (e) async {
            final updatedCountries = state.countries
                .where((element) => element.id != e.country.id)
                .toList();

            await _localStorage.delete(e.country);
            emit(state.copyWith(countries: updatedCountries));
          },
        );
      },
    );
  }
  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }
}
