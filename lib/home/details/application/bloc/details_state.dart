part of 'details_bloc.dart';

@freezed
class DetailsState with _$DetailsState {
  const factory DetailsState({
    required Country country,
  }) = _DetailsState;

  factory DetailsState.initial() => DetailsState(
        country: Country.empty(),
      );
}
