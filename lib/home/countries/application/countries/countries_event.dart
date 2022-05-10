part of 'countries_bloc.dart';

@freezed
class CountriesEvent with _$CountriesEvent {
  const factory CountriesEvent.nextItemsLoaded() = _NextItemsLoaded;
  const factory CountriesEvent.countriesLoaded() = _CountriesLoaded;
  const factory CountriesEvent.toggleFavorite(
    Country country,
    bool isFavorite,
  ) = _ToggleFavorite;
  const factory CountriesEvent.favoriteCountryRemoved(Country country) =
      _FavoriteCountryRemoved;
}
