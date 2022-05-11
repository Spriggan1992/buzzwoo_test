part of 'details_bloc.dart';

@freezed
class DetailsEvent with _$DetailsEvent {
  const factory DetailsEvent.initialized(Country country) = _Initialized;
  const factory DetailsEvent.favoritesToggled(Country country) =
      _FavoritesToggled;
  const factory DetailsEvent.countryReceived(
    Either<Failure, List<Country>> countriesOrFailure,
  ) = _CountryReceived;
  const factory DetailsEvent.favoritesStartedWatch() = _FavoritesStartedWatch;
}
