import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/failure.dart';
import '../../../core/domain/i_local_storage_subscriptions.dart';
import '../../../core/domain/models/country.dart';
import '../../domain/i_details_repository.dart';

part 'details_event.dart';
part 'details_state.dart';
part 'details_bloc.freezed.dart';

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final IDetailsRepository _detailsRepository;
  final IFavoriteSubscriptionService _favoriteSubscriptionService;
  StreamSubscription? _subscription;
  DetailsBloc(
    this._detailsRepository,
    this._favoriteSubscriptionService,
  ) : super(DetailsState.initial()) {
    on<DetailsEvent>(
      (event, emit) async {
        await event.map(
          initialized: (e) async {
            emit(state.copyWith(country: e.country));

            add(const DetailsEvent.favoritesStartedWatch());
          },
          countryReceived: (e) async {
            e.countriesOrFailure.fold((failure) => null, (countries) {
              final favorite = countries.singleWhereOrNull(
                (country) => country.id == state.country.id,
              );
              if (favorite != null) {
                emit(state.copyWith(country: favorite));
              } else {
                emit(
                  state.copyWith(
                    country: state.country.copyWith(isFavorite: false),
                  ),
                );
              }
            });
          },
          favoritesToggled: (e) async {
            if (state.country.isFavorite) {
              await _detailsRepository.removeFromFavorites(
                state.country.copyWith(
                  isFavorite: false,
                ),
              );
            } else {
              await _detailsRepository
                  .addToFavorite(state.country.copyWith(isFavorite: true));
            }
          },
          favoritesStartedWatch: (e) async {
            _subscription = null;
            _subscription = _favoriteSubscriptionService
                .watchFavoriteCountry()
                .listen((countriesOrFailure) {
              add(DetailsEvent.countryReceived(countriesOrFailure));
            });
          },
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
