part of 'favorites_bloc.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.favoritesStartedWatch() = _FavoritesStartedWatch;
  const factory FavoritesEvent.countriesReceived(List<Country> countries) =
      _CountriesReceived;
}
