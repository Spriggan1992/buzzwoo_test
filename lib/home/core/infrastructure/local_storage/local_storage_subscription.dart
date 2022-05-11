import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../../core/infrastructure/database/sembast/sembast_database.dart';
import '../../domain/country.dart';

@LazySingleton()
class LocalStorageSubscription {
  final SembastDatabase _db;

  LocalStorageSubscription(this._db);

  final StreamController<Country> _controller = StreamController.broadcast();

  /// Subscription for listening signals.
  Stream<Country> get subscription => _controller.stream;
}
