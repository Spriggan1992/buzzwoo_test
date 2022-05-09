import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/app_texts.dart';
import '../../../../core/presentation/routes/app_router.gr.dart';
import '../../../../core/presentation/themes/app_colors.dart';

import '../../core/domain/country.dart';
import '../../core/presentation/widgets/error_screens/error_screens/error_screen.dart';
import '../../core/presentation/widgets/loading_screen.dart';
import '../application/countries/countries_bloc.dart';
import 'widgets/pagination_list.dart';

const double _radius = 12;

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
    // ignore: newline-before-return
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
                  child: BlocBuilder<CountriesBloc, CountriesState>(
                    builder: (context, state) => PaginationList(
                      countries: state.countries,
                      availableToLoad: state.availableToLoad,
                      onNextItemLoaded: () => context
                          .read<CountriesBloc>()
                          .add(const CountriesEvent.nextItemsLoaded()),
                      onItemTap: (country) => context.navigateTo(
                        CountriesDetailsRouter(
                          country: country,
                        ),
                      ),
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
        ),
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
}
