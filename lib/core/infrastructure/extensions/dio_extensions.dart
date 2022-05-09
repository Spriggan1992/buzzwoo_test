import 'dart:io';

import 'package:dio/dio.dart';

/// Extension on dio error.
extension DioErrorX on DioError {
  /// Get a flag responsible for lack of internet.
  bool get isNoConnectionError =>
      type == DioErrorType.other && error is SocketException;
}
