import 'package:flutter/material.dart';

import '../extension/empty_data.dart';

class CountryInformationContainer extends StatelessWidget {
  final String title;
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
