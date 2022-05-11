import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/models/country.dart';
import 'i_local_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:sembast/sembast.dart';

import '../../../../core/domain/failure.dart';
import '../../../../core/infrastructure/database/sembast/sembast_database.dart';
import '../dtos/country_dto.dart';
import '../../domain/i_local_storage_subscriptions.dart';

/// Service for listening changes when favorites cities added or deleted from the local storage.
@LazySingleton(as: IFavoriteSubscriptionService)
class FavoriteSubscriptionService implements IFavoriteSubscriptionService {
  final SembastDatabase _db;
  final _store = StoreRef.main();

  FavoriteSubscriptionService(this._db);
  @override
  Stream<Either<Failure, List<Country>>> watchFavoriteCountry() async* {
    yield* _store.query().onSnapshots(_db.instance).map(
      (records) {
        final countries = records
            .map((e) => CountryDTO.fromJson(e.value).toDomain())
            .toList();

        return right(countries);
      },
    )..onErrorReturnWith((_, __) => left(const Failure.api()));
  }
}
