import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/domain/country.dart';
import '../../../core/infrastructure/local_storage/i_local_storage.dart';
import '../../../favorites/domain/i_favorites_repository.dart';
import '../../core/loading_state.dart';
import '../../domain/i_country_repository.dart';

part 'countries_event.dart';
part 'countries_state.dart';
part 'countries_bloc.freezed.dart';

@injectable
class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final ICountryRepository _countryRepository;
  final ILocalStorage _localStorage;
  CountriesBloc(
    this._countryRepository,
    this._localStorage,
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
          },
          nextItemsLoaded: (e) async {
            emit(
              state.copyWith(
                isNextPageLoaded: false,
                availableToLoad: false,
              ),
            );
            await Future.delayed(const Duration(milliseconds: 500));
            final response =
                await _countryRepository.getCountries(state.page + 1);
            emit(
              response.fold(
                (failure) => state.copyWith(),
                (countries) => state.copyWith(
                  countries: [...state.countries, ...countries],
                  page: state.page + 1,
                  availableToLoad: true,
                ),
              ),
            );
          },
          toggleFavorite: (e) async {
            final updatedCountries = state.countries.map((country) {
              var targetCountry = country;
              if (country.id == e.country.id) {
                targetCountry = country;
              }

              return targetCountry;
            }).toList();
            emit(state.copyWith(countries: updatedCountries));
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
}
