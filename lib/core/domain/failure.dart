import 'package:freezed_annotation/freezed_annotation.dart';
part 'failure.freezed.dart';

/// Represent home failure.
@freezed
class Failure with _$Failure {
  const Failure._();
  const factory Failure.api([int? errorCode]) = _Api;
  const factory Failure.noConnection() = _NoConnection;
}
