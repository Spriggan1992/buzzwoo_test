part of 'favorites_bloc.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.favoritesStartedWatch() = _FavoritesStartedWatch;
  const factory FavoritesEvent.favoriteCountryRemoved(Country country) =
      _FavoriteCountryRemoved;
  const factory FavoritesEvent.countriesReceived(
    Either<Failure, List<Country>> countriesOrFailure,
  ) = _CountriesReceived;
}
