import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/domain/country.dart';
import '../../domain/i_details_repository.dart';

part 'details_state.dart';
part 'details_cubit.freezed.dart';

@injectable
class DetailsCubit extends Cubit<DetailsState> {
  final IDetailsRepository _detailsRepository;
  DetailsCubit(this._detailsRepository) : super(DetailsState.initial());

  void initialized(bool isFavorite) {
    emit(state.copyWith(isFavorite: isFavorite));
  }

  Future<void> toggleFavorite(
    Country country,
    bool isFavorite,
  ) async {
    if (!isFavorite) {
      await _removeFromFavorites(country);
    } else {
      await _addToFavorite(country);
    }
  }

  Future<void> _addToFavorite(Country country) async {
    await _detailsRepository.addToFavorite(country.copyWith(isFavorite: true));
    emit(state.copyWith(isFavorite: true));
  }

  Future<void> _removeFromFavorites(Country country) async {
    await _detailsRepository.removeFromFavorites(country);
    emit(state.copyWith(isFavorite: false));
  }
}
