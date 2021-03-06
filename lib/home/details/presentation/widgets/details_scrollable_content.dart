import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/presentation/app_texts.dart';
import '../../../core/domain/models/country.dart';
import '../../../core/presentation/widgets/network_flag_image.dart';
import '../../application/bloc/details_bloc.dart';
// import '../../application/cubit/details_cubit.dart';
import 'country_information_container.dart';
import 'country_map.dart';

/// Represent scrollable content of details screen.
class DetailsScrollableContent extends StatelessWidget {
  /// Screen dimensions.
  final Size size;

  /// Country to display.
  final Country country;

  const DetailsScrollableContent({
    required this.size,
    required this.country,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Column(
              children: [
                SizedBox(
                  height: size.height * 0.3,
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      CountryMap(
                        latLng: country.hasLocationData
                            ? LatLng(
                                double.parse(
                                  country.latitude,
                                ),
                                double.parse(
                                  country.longitude,
                                ),
                              )
                            : null,
                      ),
                      if (country.hasLocationData)
                        Align(
                          alignment: const Alignment(0, 1.65),
                          child: NetworkFlagImage(
                            country.flagUrl,
                            height: 90,
                            width: 120,
                          ),
                        ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, right: 8),
                          child: BlocSelector<DetailsBloc, DetailsState, bool>(
                            selector: (state) => state.country.isFavorite,
                            builder: (context, isFavorite) {
                              return isFavorite
                                  ? const Icon(
                                      CupertinoIcons.heart_fill,
                                      color: Colors.red,
                                      size: 24,
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  country.capitalCity,
                  style: Theme.of(context).textTheme.headline2,
                ),
                CountryInformationContainer(
                  AppTexts.countryCode,
                  country.countryCode,
                ),
                CountryInformationContainer(
                  AppTexts.capitalCity,
                  country.capitalCity,
                ),
                CountryInformationContainer(
                  AppTexts.region,
                  country.region.name,
                ),
                CountryInformationContainer(
                  AppTexts.incomeLevel,
                  country.incomeLevel.value,
                ),
              ],
            ),
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
