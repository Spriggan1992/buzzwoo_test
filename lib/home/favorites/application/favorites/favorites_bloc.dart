import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/failure.dart';
import '../../../core/domain/country.dart';
import '../../domain/i_favorites_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';
part 'favorites_bloc.freezed.dart';

@injectable
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final IFavoritesRepository _favoritesRepository;
  StreamSubscription? _subscription;
  FavoritesBloc(this._favoritesRepository)
      : super(const FavoritesState.initial()) {
    on<FavoritesEvent>(
      (event, emit) async {
        await event.map(
          favoritesStartedWatch: (e) async {
            emit(const FavoritesState.loading());
            final favorites =
                await _favoritesRepository.getFavoritesCountries();
            emit(
              favorites.fold(
                (failure) => FavoritesState.failure(failure),
                (countries) => FavoritesState.success(
                  countries,
                ),
              ),
            );

            _subscription = null;
            _subscription = _favoritesRepository.watchFavoriteCountry().listen(
              (favorites) {
                add(FavoritesEvent.countriesReceived(favorites));
              },
            );
          },
          countriesReceived: (e) async {
            emit(
              e.countriesOrFailure.fold(
                (failure) => FavoritesState.failure(failure),
                (countries) => FavoritesState.success(countries),
              ),
            );
          },
        );
      },
    );
  }
  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }
}
