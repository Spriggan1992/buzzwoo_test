import 'package:auto_route/auto_route.dart';

import '../../../home/core/presentation/home_screen.dart';
import '../../../home/countries/presentation/countries_screen.dart';
import '../../../home/details/presentation/details_screen.dart';
import '../../../home/favorites/favorites_screen.dart';
import '../../../splash/splash_screen.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute(
      page: SplashScreen,
      initial: true,
    ),
    AutoRoute(
      page: HomeScreen,
      children: [
        AutoRoute(
          initial: true,
          name: 'CountriesTab',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              name: 'CountriesRouter',
              page: CountriesScreen,
            ),
            AutoRoute(
              name: 'CountriesDetailsRouter',
              path: ':countriesDetailsScreen',
              page: DetailsScreen,
            ),
          ],
        ),
        AutoRoute(
          path: '',
          name: 'FavoritesTab',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: FavoritesScreen,
            ),
            AutoRoute(
              name: 'FavoriteDetailsRouter',
              path: ':favoriteDetailsScreen',
              page: DetailsScreen,
            ),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
