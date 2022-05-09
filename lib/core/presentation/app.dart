import 'package:flutter/material.dart';
import '../../injection.dart';
import 'routes/app_router.gr.dart';
import 'themes/app_themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: appThemeData,
      routerDelegate: getIt<AppRouter>().delegate(),
      routeInformationParser: getIt<AppRouter>().defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
