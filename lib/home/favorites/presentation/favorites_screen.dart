import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/app_texts.dart';
import '../../../core/presentation/routes/app_router.gr.dart';
import '../../../core/presentation/themes/app_colors.dart';
import '../../../core/presentation/utils/app_constants.dart';
import '../../core/domain/models/country.dart';
import '../../core/presentation/widgets/country_list_item.dart';
import '../../core/presentation/widgets/error_screens/error_screens/error_screen.dart';
import '../../core/presentation/widgets/scaffolds/app_scaffold.dart';
import '../../core/presentation/widgets/scaffolds/loading_screen.dart';
import '../../core/presentation/widgets/wrappers/dismissible_wrapper.dart';

import '../application/favorites/favorites_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return state.when(
          initial: () => const LoadingScreen(),
          loading: () => const LoadingScreen(),
          success: (countries) => _FavoritesScreenContent(countries: countries),
          failure: (failure) => ErrorScreen(
            failure: failure,
            onTryAgain: () => onTryAgainPressedHandler(context),
          ),
        );
      },
    );
  }

  void onTryAgainPressedHandler(BuildContext context) {
    context
        .read<FavoritesBloc>()
        .add(const FavoritesEvent.favoritesStartedWatch());
  }
}

class _FavoritesScreenContent extends StatelessWidget {
  final List<Country> countries;
  const _FavoritesScreenContent({
    required this.countries,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.favorites,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 12),
          countries.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppConstants.borderRadius12,
                  ),
                  child: const Text(AppTexts.emptyFavoriteCountries),
                )
              : Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppConstants.borderRadius12,
                    ),
                    child: ListView.separated(
                      padding: countries.length > 6 ? null : EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => DismissibleWrapper(
                        onTap: () => _onNavigateToDetailsScreen(
                          context,
                          countries[index],
                        ),
                        country: countries[index],
                        onRemove: (country) =>
                            _onRemoveHandler(context, country),
                        child: CountryListItem(countries[index]),
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: countries.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void _onNavigateToDetailsScreen(BuildContext context, Country country) {
    context.navigateTo(
      FavoriteDetailsRouter(country: country),
    );
  }

  bool _onRemoveHandler(BuildContext context, Country country) {
    context
        .read<FavoritesBloc>()
        .add(FavoritesEvent.favoriteCountryRemoved(country));

    return true;
  }
}
