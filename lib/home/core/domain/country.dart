import 'package:freezed_annotation/freezed_annotation.dart';

import 'income_level.dart';
import 'region.dart';
part 'country.freezed.dart';

/// Defines country model.
@freezed
class Country with _$Country {
  const Country._();
  const factory Country({
    /// Country identifier.
    required String id,

    /// Country code.
    required String countryCode,

    /// Country name.
    required String name,

    /// The region of the country.
    required Region region,

    /// The level of country income.
    required IncomeLevel incomeLevel,

    /// Capital of the city.
    required String capitalCity,

    /// The longitude.
    required String longitude,

    /// The latitude.
    required String latitude,

    /// Whether the country added to the favorites.
    required bool isFavorite,
  }) = _Country;

  /// Empty country model.
  factory Country.empty() => Country(
        id: '',
        countryCode: '',
        name: '',
        isFavorite: false,
        region: Region.empty(),
        incomeLevel: IncomeLevel.empty(),
        capitalCity: '',
        latitude: '',
        longitude: '',
      );

  String get flagUrl =>
      'https://flagcdn.com/h120/${countryCode.toLowerCase()}.png';

  bool get hasLocationData => latitude.isNotEmpty && longitude.isNotEmpty;
}
