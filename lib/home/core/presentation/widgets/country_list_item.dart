import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/themes/app_colors.dart';
import '../../domain/models/country.dart';
import 'network_flag_image.dart';

/// Represents the country display list items.
class CountryListItem extends StatelessWidget {
  /// Country to display.
  final Country country;

  const CountryListItem(
    this.country, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NetworkFlagImage(country.flagUrl, height: 60),
          SizedBox(
            width: 130,
            child: Text(
              country.name,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Row(
            children: [
              if (country.isFavorite)
                const Icon(
                  CupertinoIcons.heart_fill,
                  size: 30,
                  color: Colors.red,
                ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.gray2.withOpacity(0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
