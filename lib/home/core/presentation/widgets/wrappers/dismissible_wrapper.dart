import 'package:flutter/material.dart';

import '../../../../../core/presentation/app_texts.dart';
import '../../../../../core/presentation/themes/app_colors.dart';
import '../../../../../core/presentation/utils/app_constants.dart';
import '../../../domain/models/country.dart';

/// Represents a wrapper around a list element so that the element can be removed using
/// right-to-left swipe
class DismissibleWrapper extends StatelessWidget {
  /// Country to display.
  final Country country;

  /// Called when the user removes an item from the list.
  final Function(Country country) onRemove;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Called when the user taps this list item.
  final VoidCallback onTap;

  const DismissibleWrapper({
    required this.country,
    required this.onRemove,
    required this.child,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: AppConstants.borderRadius12,
      color: AppColors.white,
      child: InkWell(
        splashColor: AppColors.gray5,
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: AppConstants.borderRadius12,
          ),
          child: Dismissible(
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
          ),
        ),
      ),
    );
  }
}
