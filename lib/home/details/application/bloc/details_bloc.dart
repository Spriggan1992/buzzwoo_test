import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/country.dart';
import '../../domain/i_details_repository.dart';

part 'details_event.dart';
part 'details_state.dart';
part 'details_bloc.freezed.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final IDetailsRepository _detailsRepository;
  DetailsBloc(this._detailsRepository) : super(DetailsState.initial()) {
    on<DetailsEvent>((event, emit) async {
      await event.map(
        initialized: (e) async {
          emit(state.copyWith(isFavorite: e.isFavorite));
        },
        favoritesToggled: (e) async {
          if (e.isFavorite) {
            await _addToFavorite(e.country, emit);
          } else {
            await _removeFromFavorites(e.country, emit);
          }
        },
        favoritesStartedWatch: (e) async {},
      );
    });
  }
  Future<void> _addToFavorite(
    Country country,
    Emitter<DetailsState> emit,
  ) async {
    await _detailsRepository.addToFavorite(country.copyWith(isFavorite: true));
    emit(state.copyWith(isFavorite: true));
  }

  Future<void> _removeFromFavorites(
    Country country,
    Emitter<DetailsState> emit,
  ) async {
    await _detailsRepository.removeFromFavorites(country);
    emit(state.copyWith(isFavorite: false));
  }
}
