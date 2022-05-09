import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'core/infrastructure/config/config_reader.dart';
import 'injection.config.dart';

/// Getting instance of [GetIt]
final GetIt getIt = GetIt.instance;

/// initializing the configurations of [GetIt].
///
/// `env` environment
@injectableInit
Future<void> configureInjection([String? env]) async {
  $initGetIt(getIt, environment: env);

  await _initInjection();
}

Future<void> _initInjection() async {
  await getIt<ConfigReader>().init();
}
