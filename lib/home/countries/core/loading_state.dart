import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/domain/failure.dart';
part 'loading_state.freezed.dart';

/// Represent states for loading data.
@freezed
class LoadingState with _$LoadingState {
  const factory LoadingState.initial() = _Initial;
  const factory LoadingState.loading() = _Loading;
  const factory LoadingState.success() = _Success;
  const factory LoadingState.failure(Failure failure) = _Failure;
}
