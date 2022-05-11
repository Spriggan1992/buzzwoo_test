import 'package:dartz/dartz.dart';

import '../../../core/domain/failure.dart';
import 'models/country.dart';

/// Describe service for listening changes when favorites cities added or deleted from the local storage.
abstract class IFavoriteSubscriptionService {
  /// Start to watch listening changes in local storage.
  Stream<Either<Failure, List<Country>>> watchFavoriteCountry();
}
