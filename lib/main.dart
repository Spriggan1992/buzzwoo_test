import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'core/infrastructure/database/sembast/sembast_database.dart';
import 'core/presentation/app.dart';
import 'core/presentation/app_icons.dart';
import 'core/presentation/routes/app_router.gr.dart';
import 'core/presentation/utils/image_utils.dart';
import 'injection.dart';

Future<void> main() async {
  await _appInitializer();
}

/// Initializes dependencies.
Future<void> _appInitializer() async {
  final widgetsBindingInstance = WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  await getIt<SembastDatabase>().init();
  getIt.registerSingleton<AppRouter>(AppRouter());
  await preloadImages(
    [
      const AssetImage(AppIcons.pirate_flag),
    ],
    widgetsBindingInstance.window.devicePixelRatio,
  );
  BlocOverrides.runZoned(
    () => runApp(const App()),
  );
}
