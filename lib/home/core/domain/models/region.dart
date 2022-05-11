import 'package:freezed_annotation/freezed_annotation.dart';
part 'region.freezed.dart';

/// Defines region model.
@freezed
class Region with _$Region {
  const Region._();
  const factory Region({
    /// The name of the region.
    required String name,
  }) = _Region;

  /// Empty region model..
  factory Region.empty() => const Region(name: '');
}
