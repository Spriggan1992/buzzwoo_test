import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/app_texts.dart';
import '../../../core/presentation/themes/app_colors.dart';
import '../../../injection.dart';
import '../../core/domain/country.dart';
import '../../countries/application/countries/countries_bloc.dart';
import '../application/cubit/details_cubit.dart';
import 'widgets/details_scrollable_content.dart';
import 'widgets/favorite_button.dart';

class DetailsScreen extends StatelessWidget {
  final Country country;
  const DetailsScreen(
    this.country, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) =>
          getIt<DetailsCubit>()..initialized(country.isFavorite),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: double.infinity,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                onTap: () => context.popRoute(),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back_ios),
                    Text(AppTexts.countries),
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: AppColors.white,
            child: Column(
              children: [
                Expanded(
                  child: DetailsScrollableContent(
                    size: size,
                    country: country,
                  ),
                ),
                BlocBuilder<DetailsCubit, DetailsState>(
                  builder: (context, state) {
                    return FavoriteButton(
                      isFavorite: country.isFavorite,
                      onTap: (isFavorite) =>
                          _onButtonTapHandler(context, isFavorite),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onButtonTapHandler(BuildContext context, bool isFavorite) {
    context
        .read<CountriesBloc>()
        .add(CountriesEvent.toggleFavorite(country, isFavorite));
    context.read<DetailsCubit>().toggleFavorite(country, isFavorite);
  }
}
