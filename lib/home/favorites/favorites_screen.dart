import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/presentation/app_texts.dart';
import '../../core/presentation/routes/app_router.gr.dart';
import '../../core/presentation/themes/app_colors.dart';
import '../../injection.dart';
import '../core/domain/country.dart';
import '../core/presentation/widgets/country_list_item.dart';
import '../core/presentation/widgets/error_screens/error_screens/error_screen.dart';
import '../core/presentation/widgets/loading_screen.dart';
import 'application/favorites/favorites_bloc.dart';

const double _radius = 12;

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return state.when(
          initial: () => const LoadingScreen(),
          loading: () => const LoadingScreen(),
          success: (countries) => _CountriesScreenContent(countries: countries),
          failure: (failure) => ErrorScreen(
            failure: failure,
            onTryAgain: () {},
          ),
        );
      },
    );
  }
}

class _CountriesScreenContent extends StatelessWidget {
  final List<Country> countries;
  const _CountriesScreenContent({
    required this.countries,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(countries.toString(), name: "COUNTRIES");
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.countries,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_radius),
                      topRight: Radius.circular(_radius),
                    ),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemBuilder: (context, index) => CountryListItem(
                      countries[index],
                      onTap: () => context.navigateTo(
                        FavoriteDetailsRouter(country: countries[index]),
                      ),
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: countries.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
