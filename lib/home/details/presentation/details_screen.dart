import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/app_texts.dart';
import '../../../core/presentation/themes/app_colors.dart';
import '../../../injection.dart';
import '../../core/domain/models/country.dart';
import '../application/bloc/details_bloc.dart';
import 'widgets/details_scrollable_content.dart';
import 'widgets/favorite_button.dart';

class DetailsScreen extends StatefulWidget {
  final Country country;
  const DetailsScreen(
    this.country, {
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) =>
          getIt<DetailsBloc>()..add(DetailsEvent.initialized(widget.country)),
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
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primary,
                    ),
                    Text(
                      AppTexts.countries,
                      style: TextStyle(color: AppColors.primary),
                    ),
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
                    country: widget.country,
                  ),
                ),
                BlocBuilder<DetailsBloc, DetailsState>(
                  builder: (context, state) {
                    return FavoriteButton(
                      isFavorite: state.country.isFavorite,
                      onTap: () => _onButtonTapHandler(context, state.country),
                    );
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onButtonTapHandler(BuildContext context, Country country) {
    context.read<DetailsBloc>().add(DetailsEvent.favoritesToggled(country));
  }
}
