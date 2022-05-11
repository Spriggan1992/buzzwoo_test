import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/app_texts.dart';
import '../../../../core/presentation/routes/app_router.gr.dart';
import '../../../../core/presentation/themes/app_colors.dart';

import '../../../core/presentation/utils/app_constants.dart';
import '../../core/domain/models/country.dart';
import '../../core/presentation/widgets/error_screens/error_screens/error_screen.dart';
import '../../core/presentation/widgets/scaffolds/app_scaffold.dart';
import '../../core/presentation/widgets/scaffolds/loading_screen.dart';
import '../application/countries/countries_bloc.dart';
import 'widgets/pagination_list.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesBloc, CountriesState>(
      builder: (context, state) {
        return state.loadingState.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          initial: () => const LoadingScreen(),
          loading: () => const LoadingScreen(),
          success: () => _CountriesScreenContent(countries: state.countries),
          failure: (failure) => ErrorScreen(
            failure: failure,
            onTryAgain: () => context.read<CountriesBloc>().add(
                  const CountriesEvent.countriesLoaded(),
                ),
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
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.countries,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: AppConstants.borderRadius12,
              ),
              child: BlocBuilder<CountriesBloc, CountriesState>(
                builder: (context, state) => PaginationList(
                  onRefresh: () async => _onRefreshHandler(context),
                  countries: state.countries,
                  availableToLoad: state.availableToLoad,
                  onNextItemLoaded: () => _onNextItemLoadedHandler(context),
                  onItemTap: (country) =>
                      _onDetailsScreenNavigateHandler(context, country),
                  onRemove: (country) => _removeCountryHandler(
                    context,
                    country,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _removeCountryHandler(
    BuildContext context,
    Country country,
  ) {
    context.read<CountriesBloc>().add(
          CountriesEvent.favoriteCountryRemoved(
            country,
          ),
        );

    return true;
  }

  void _onDetailsScreenNavigateHandler(
    BuildContext context,
    Country country,
  ) {
    context.navigateTo(
      CountriesDetailsRouter(
        country: country,
      ),
    );
  }

  void _onNextItemLoadedHandler(BuildContext context) {
    context.read<CountriesBloc>().add(const CountriesEvent.nextItemsLoaded());
  }

  void _onRefreshHandler(BuildContext context) {
    context.read<CountriesBloc>().add(const CountriesEvent.countriesLoaded());
  }
}
