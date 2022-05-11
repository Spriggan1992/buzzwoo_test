import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/domain/country.dart';
import '../../domain/i_details_repository.dart';

part 'details_event.dart';
part 'details_state.dart';
part 'details_bloc.freezed.dart';

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final IDetailsRepository _detailsRepository;
  StreamSubscription? _subscription;
  DetailsBloc(this._detailsRepository) : super(DetailsState.initial()) {
    on<DetailsEvent>(
      (event, emit) async {
        await event.map(
          initialized: (e) async {
            emit(state.copyWith(country: e.country));

            _subscription = null;
            _subscription = _detailsRepository
                .removedCountrySubscription()
                .listen((country) {
              add(DetailsEvent.deletedFavoriteCountryReceived(country));
            });
          },
          deletedFavoriteCountryReceived: (e) async {
            if (state.country.id == e.country.id) {
              emit(
                state.copyWith(
                  country: state.country.copyWith(
                    isFavorite: false,
                  ),
                ),
              );
            }
          },
          favoritesToggled: (e) async {
            if (state.country.isFavorite) {
              await _detailsRepository.removeFromFavorites(state.country);
            } else {
              await _detailsRepository
                  .addToFavorite(state.country.copyWith(isFavorite: true));
              emit(
                state.copyWith(
                  country: state.country.copyWith(isFavorite: true),
                ),
              );
            }
          },
          favoritesStartedWatch: (e) async {},
        );
      },
    );
  }
  @override
  Future<void> close() async {
    _subscription?.cancel();

    return super.close();
  }
}
