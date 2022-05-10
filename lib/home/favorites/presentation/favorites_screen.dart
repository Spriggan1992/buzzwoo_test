import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/app_texts.dart';
import '../../../core/presentation/routes/app_router.gr.dart';
import '../../../core/presentation/themes/app_colors.dart';
import '../../core/domain/country.dart';
import '../../core/presentation/widgets/country_list_item.dart';
import '../../core/presentation/widgets/error_screens/error_screens/error_screen.dart';
import '../../core/presentation/widgets/scaffolds/loading_screen.dart';
import '../../core/presentation/widgets/wrappers/dismissible_wrapper.dart';
import '../../countries/application/countries/countries_bloc.dart';
import '../../details/application/cubit/details_cubit.dart';
import '../application/favorites/favorites_bloc.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.favorites,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 12),
              Flexible(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_radius),
                      topRight: Radius.circular(_radius),
                    ),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemBuilder: (context, index) => DismissibleWrapper(
                      country: countries[index],
                      onRemove: (Country country) =>
                          _onRemoveHandler(context, country),
                      child: CountryListItem(
                        countries[index],
                        onTap: () => _onNavigateToDetailsScreen(
                          context,
                          countries[index],
                        ),
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

  void _onNavigateToDetailsScreen(BuildContext context, Country country) {
    context.navigateTo(
      FavoriteDetailsRouter(country: country),
    );
  }

  bool _onRemoveHandler(BuildContext context, Country country) {
    context
        .read<CountriesBloc>()
        .add(CountriesEvent.toggleFavorite(country, false));
    context.read<DetailsCubit>().toggleFavorite(country, false);

    return true;
  }
}
