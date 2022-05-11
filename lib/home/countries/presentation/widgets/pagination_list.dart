import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/app_texts.dart';
import '../../../core/domain/models/country.dart';
import '../../../core/presentation/widgets/country_list_item.dart';
import '../../../core/presentation/widgets/wrappers/dismissible_wrapper.dart';

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

  /// Called when user pull to refresh list.
  final Future<void> Function() onRefresh;

  const PaginationList({
    required this.countries,
    required this.availableToLoad,
    required this.onNextItemLoaded,
    required this.onItemTap,
    required this.onRemove,
    required this.onRefresh,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onNotificationHandler,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.separated(
          padding: countries.length > 6 ? null : EdgeInsets.zero,
          itemBuilder: (context, index) {
            final isShowLoadingIndicator =
                countries.length == index && !availableToLoad;

            return isShowLoadingIndicator
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
                : DismissibleWrapper(
                    onTap: () => onItemTap(
                      countries[index],
                    ),
                    country: countries[index],
                    onRemove: onRemove,
                    child: CountryListItem(countries[index]),
                  );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: !availableToLoad ? countries.length + 1 : countries.length,
        ),
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
