import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/country.dart';
import 'income_level_dto.dart';
import 'region_dto.dart';
part 'country_dto.freezed.dart';
part 'country_dto.g.dart';

/// Defines country data transfer object.
@freezed
class CountryDTO with _$CountryDTO {
  const CountryDTO._();
  const factory CountryDTO({
    /// Country identifier.
    @JsonKey(name: 'id') required String id,

    /// Country code.
    @JsonKey(name: 'iso2Code') required String countryCode,

    /// Country name.
    @JsonKey(name: 'name') required String name,

    /// Region of the country.
    @JsonKey(name: 'region') required Map<String, dynamic> region,

    /// Income level of the country.
    @JsonKey(name: 'incomeLevel') required Map<String, dynamic> incomeLevel,

    /// The capital city of the country.
    @JsonKey(name: 'capitalCity') required String capitalCity,

    /// The longitude.
    ///
    @JsonKey(name: 'longitude') required String longitude,

    /// The latitude.
    @JsonKey(name: 'latitude') required String latitude,
  }) = _CountryDTO;

  /// Return converted DTO from domain.
  factory CountryDTO.fromDomain(Country _) => CountryDTO(
        id: _.id,
        countryCode: _.countryCode,
        name: _.name,
        region: RegionDTO.fromDomain(_.region).toJson(),
        incomeLevel: IncomeLevelDTO.fromDomain(_.incomeLevel).toJson(),
        capitalCity: _.capitalCity,
        latitude: _.latitude,
        longitude: _.longitude,
      );

  /// Return converted DTO from json.
  factory CountryDTO.fromJson(Map<String, dynamic> json) =>
      _$CountryDTOFromJson(json);

  /// Convert object to json.
  factory CountryDTO.toJson() => CountryDTO.toJson();

  /// Convert DTO to domain.
  Country toDomain() => Country(
        id: id,
        countryCode: countryCode,
        name: name,
        isFavorite: true,
        region: RegionDTO.fromJson(region).toDomain(),
        incomeLevel: IncomeLevelDTO.fromJson(incomeLevel).toDomain(),
        capitalCity: capitalCity,
        latitude: latitude,
        longitude: longitude,
      );
}
