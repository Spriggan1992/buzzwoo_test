import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/country.dart';
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

    /// Country name.
    @JsonKey(name: 'region') required Map<String, dynamic> region,

    /// Country name.
    @JsonKey(name: 'incomeLevel') required Map<String, dynamic> incomeLevel,

    /// Country name.
    @JsonKey(name: 'capitalCity') required String capitalCity,

    /// Country name.
    ///
    @JsonKey(name: 'longitude') required String longitude,

    /// Country name.
    @JsonKey(name: 'latitude') required String latitude,
  }) = _CountryDTO;

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
        // latitude: latitude.isEmpty ? _latitude : latitude,
        // longitude: longitude.isEmpty ? _longitude : longitude,
      );
}
