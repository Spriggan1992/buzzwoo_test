import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/income_level.dart';
part 'income_level_dto.freezed.dart';
part 'income_level_dto.g.dart';

/// Defines the income level data transfer object.
@freezed
class IncomeLevelDTO with _$IncomeLevelDTO {
  const IncomeLevelDTO._();
  const factory IncomeLevelDTO({
    /// The value of income level.
    @JsonKey(name: 'value') required String value,
  }) = _IncomeLevelDTO;

  /// Return converted DTO from domain.
  factory IncomeLevelDTO.fromDomain(IncomeLevel _) =>
      IncomeLevelDTO(value: _.value);

  /// Return converted DTO from json.
  factory IncomeLevelDTO.fromJson(Map<String, dynamic> json) =>
      _$IncomeLevelDTOFromJson(json);

  /// Convert object to json.
  factory IncomeLevelDTO.toJson() => IncomeLevelDTO.toJson();

  /// Convert DTO to domain.
  IncomeLevel toDomain() => IncomeLevel(value: value);
}
