import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/app_texts.dart';
import '../../../core/domain/country.dart';
import '../../../core/presentation/widgets/country_list_item.dart';

/// Represent list view with pagination.
class PaginationList extends StatelessWidget {
  /// Countries displayed in the list
  final List<Country> countries;

  /// Whether to can load next data.
  final bool availableToLoad;

  /// Load event handler for the following list items.
  final VoidCallback onNextItemLoaded;

  /// Called when the user taps this list item.
  final Function(Country) onItemTap;

  /// Called when the user removes an item from the list.
  final Function(Country country) onRemove;
  const PaginationList({
    required this.countries,
    required this.availableToLoad,
    required this.onNextItemLoaded,
    required this.onItemTap,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onNotificationHandler,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemBuilder: (context, index) {
          return countries.length == index && !availableToLoad
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(AppTexts.loading),
                      CupertinoActivityIndicator(),
                    ],
                  ),
                )
              : Dismissible(
                  confirmDismiss: (_) async => onRemove(countries[index]),
                  key: ValueKey(countries[index].id),
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
                            Icon(Icons.delete_outline, color: Colors.white),
                            Text(
                              AppTexts.remove,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  direction: countries[index].isFavorite
                      ? DismissDirection.endToStart
                      : DismissDirection.none,
                  child: CountryListItem(
                    countries[index],
                    onTap: () => onItemTap(
                      countries[index],
                    ),
                  ),
                );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: !availableToLoad ? countries.length + 1 : countries.length,
      ),
    );
  }

  bool _onNotificationHandler(ScrollNotification notification) {
    final metrics = notification.metrics;
    final limit = metrics.maxScrollExtent - metrics.viewportDimension - 100;

    if (metrics.pixels >= limit && availableToLoad) {
      onNextItemLoaded();
    }

    return true;
  }
}
