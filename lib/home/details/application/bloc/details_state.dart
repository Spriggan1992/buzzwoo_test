part of 'details_bloc.dart';

@freezed
class DetailsState with _$DetailsState {
  const factory DetailsState({
    required bool isFavorite,
  }) = _DetailsState;

  factory DetailsState.initial() => const DetailsState(isFavorite: false);
}
