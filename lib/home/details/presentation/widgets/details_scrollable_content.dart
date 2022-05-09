import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/domain/country.dart';
import '../../../core/presentation/widgets/network_flag_image.dart';
import '../../application/cubit/details_cubit.dart';
import 'country_information_container.dart';
import 'country_map.dart';

class DetailsScrollableContent extends StatelessWidget {
  final Size size;
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
            ((context, index) => Column(
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
                              child: BlocSelector<DetailsCubit, DetailsState,
                                  bool>(
                                selector: (state) => state.isFavorite,
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
                      'Country code',
                      country.countryCode,
                    ),
                    CountryInformationContainer(
                      'Capital City',
                      country.capitalCity,
                    ),
                    CountryInformationContainer(
                      'Region',
                      country.region.name,
                    ),
                    CountryInformationContainer(
                      'Income level',
                      country.incomeLevel.value,
                    ),
                  ],
                )),
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
