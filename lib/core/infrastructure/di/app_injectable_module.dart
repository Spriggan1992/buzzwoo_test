import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../database/sembast/sembast_database.dart';

/// Main module for injection.
@module
abstract class AppInjectableModule {
  /// Initialized dio client.
  @lazySingleton
  Dio get dio => Dio();
}
