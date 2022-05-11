part of 'countries_bloc.dart';

@freezed
class CountriesEvent with _$CountriesEvent {
  const factory CountriesEvent.nextItemsLoaded() = _NextItemsLoaded;
  const factory CountriesEvent.countriesLoaded() = _CountriesLoaded;
  const factory CountriesEvent.favoriteCountriesReceived(
    Either<Failure, List<Country>> countriesOrFailure,
  ) = _FavoriteCountriesReceived;
  const factory CountriesEvent.favoritesStartedWatch() = _FavoritesStartedWatch;

  const factory CountriesEvent.favoriteCountryRemoved(Country country) =
      _FavoriteCountryRemoved;
}
