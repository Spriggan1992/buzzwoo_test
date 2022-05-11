import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/app_texts.dart';
import '../../../core/presentation/routes/app_router.gr.dart';
import '../../../injection.dart';
import '../../countries/application/countries/countries_bloc.dart';
import '../../details/application/bloc/details_bloc.dart';
import '../../details/application/cubit/details_cubit.dart';
import '../../favorites/application/favorites/favorites_bloc.dart';

const _routes = [
  CountriesTab(),
  FavoritesTab(),
];

/// Represent home screen.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CountriesBloc>()
            ..add(const CountriesEvent.countriesLoaded()),
        ),
        BlocProvider(
          create: (context) => getIt<FavoritesBloc>()
            ..add(const FavoritesEvent.favoritesStartedWatch()),
        ),
      ],
      child: AutoTabsScaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        routes: _routes,
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.flag),
                label: AppTexts.countries,
              ),
              BottomNavigationBarItem(
                label: AppTexts.favorites,
                icon: Icon(CupertinoIcons.heart_fill),
              ),
            ],
          );
        },
      ),
    );
  }
}
