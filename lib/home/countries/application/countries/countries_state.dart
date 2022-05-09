part of 'countries_bloc.dart';

@freezed
class CountriesState with _$CountriesState {
  const factory CountriesState({
    required LoadingState loadingState,
    required List<Country> countries,
    required bool isNextPageLoaded,
    required bool availableToLoad,
    required int page,
  }) = _CountriesState;
  factory CountriesState.initial() => const CountriesState(
        countries: [],
        isNextPageLoaded: false,
        availableToLoad: true,
        page: 1,
        loadingState: LoadingState.initial(),
      );
}
