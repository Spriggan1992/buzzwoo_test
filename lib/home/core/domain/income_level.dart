import 'package:freezed_annotation/freezed_annotation.dart';
part 'income_level.freezed.dart';

/// Defines income level model.
@freezed
class IncomeLevel with _$IncomeLevel {
  const IncomeLevel._();
  const factory IncomeLevel({
    /// The value of income level.
    required String value,
  }) = _IncomeLevel;

  /// Empty income level model.
  factory IncomeLevel.empty() => const IncomeLevel(value: '');
}
