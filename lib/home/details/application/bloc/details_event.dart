part of 'details_bloc.dart';

@freezed
class DetailsEvent with _$DetailsEvent {
  const factory DetailsEvent.initialized(bool isFavorite) = _Initialized;
  const factory DetailsEvent.favoritesToggled(
      Country country, bool isFavorite) = _FavoritesToggled;
  const factory DetailsEvent.favoritesStartedWatch() = _FavoritesStartedWatch;
}
