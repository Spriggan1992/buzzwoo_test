import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/region.dart';
part 'region_dto.freezed.dart';
part 'region_dto.g.dart';

/// Defines region data transfer object.
@freezed
class RegionDTO with _$RegionDTO {
  const RegionDTO._();
  const factory RegionDTO({
    /// The name of the region.
    @JsonKey(name: 'value') required String name,
  }) = _RegionDTO;

  /// Return converted DTO from domain.
  factory RegionDTO.fromDomain(Region _) => RegionDTO(name: _.name);

  /// Return converted DTO from json.
  factory RegionDTO.fromJson(Map<String, dynamic> json) =>
      _$RegionDTOFromJson(json);

  /// Convert object to json.
  factory RegionDTO.toJson() => RegionDTO.toJson();

  /// Convert DTO to domain.
  Region toDomain() => Region(name: name);
}
