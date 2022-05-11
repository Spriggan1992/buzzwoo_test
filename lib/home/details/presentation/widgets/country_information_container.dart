import 'package:flutter/material.dart';

import '../extension/empty_data.dart';

/// Represent detailed information about country.
class CountryInformationContainer extends StatelessWidget {
  /// Title of the country info to display.
  final String title;

  /// Value of the country info to display.
  final String value;
  const CountryInformationContainer(
    this.title,
    this.value, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline5),
          Text(value.emptyData),
        ],
      ),
    );
  }
}
