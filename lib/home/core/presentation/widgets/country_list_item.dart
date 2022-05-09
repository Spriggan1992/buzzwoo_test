import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/country.dart';
import 'network_flag_image.dart';

/// Represents the country display list items.
class CountryListItem extends StatelessWidget {
  /// Country to display.
  final Country country;

  /// Called when the user taps this list item.
  final VoidCallback onTap;

  const CountryListItem(
    this.country, {
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      visualDensity: const VisualDensity(vertical: 4),
      leading: NetworkFlagImage(country.flagUrl),
      title: Text(
        country.name,
        style: Theme.of(context).textTheme.headline5,
      ),
      trailing: SizedBox(
        width: 60,
        child: Row(
          children: [
            if (country.isFavorite)
              const Icon(
                CupertinoIcons.heart_fill,
                size: 30,
                color: Colors.red,
              ),
            const Expanded(
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
