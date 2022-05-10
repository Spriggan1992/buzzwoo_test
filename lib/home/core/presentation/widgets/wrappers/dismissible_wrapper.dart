import 'package:flutter/material.dart';

import '../../../../../core/presentation/app_texts.dart';
import '../../../domain/country.dart';
import '../country_list_item.dart';

/// Represents a wrapper around a list element so that the element can be removed using
/// right-to-left swipe
class DismissibleWrapper extends StatelessWidget {
  /// Country to display.
  final Country country;

  /// Called when the user removes an item from the list.
  final Function(Country country) onRemove;

  /// The widget below this widget in the tree.
  final Widget child;
  const DismissibleWrapper({
    required this.country,
    required this.onRemove,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (_) async => onRemove(country),
      key: ValueKey(country.id),
      background: Container(color: Colors.red),
      secondaryBackground: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
                Text(
                  AppTexts.remove,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      direction: country.isFavorite
          ? DismissDirection.endToStart
          : DismissDirection.none,
      child: child,
    );
  }
}
