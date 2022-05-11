part of 'details_bloc.dart';

@freezed
class DetailsEvent with _$DetailsEvent {
  const factory DetailsEvent.initialized(Country country) = _Initialized;
  const factory DetailsEvent.favoritesToggled(Country country) =
      _FavoritesToggled;
  const factory DetailsEvent.deletedFavoriteCountryReceived(Country country) =
      _DeletedFavoriteCountryReceived;
  const factory DetailsEvent.favoritesStartedWatch() = _FavoritesStartedWatch;
}
