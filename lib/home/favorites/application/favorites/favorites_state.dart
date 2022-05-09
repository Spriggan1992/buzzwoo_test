part of 'favorites_bloc.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.initial() = _Initial;
  const factory FavoritesState.loading() = _Loading;
  const factory FavoritesState.success(List<Country> countries) = _Success;
  const factory FavoritesState.failure(Failure failure) = _Failure;
}
