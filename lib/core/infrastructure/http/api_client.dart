import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../injection.dart';
import '../../domain/failure.dart';
import '../config/dio_base_options.dart';
import '../utils/make_request.dart';

/// Represent api for making request.
@LazySingleton()
class ApiClient {
  late Dio _dio;

  ApiClient() {
    _dio = getIt<Dio>()..options = baseOptions;
  }

  /// The method to make http GET request, which is a alias of [dio.fetch(RequestOptions)].
  Future<Either<Failure, T>> get<T>(
    String path, {
    required Future<T> Function(Response<dynamic> response) responseParser,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return makeRequest<T>(
      () async {
        final response = await _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );

        return responseParser(response);
      },
    );
  }

  /// The method to make http POST request, which is a alias of [dio.fetch(RequestOptions)].
  Future<Either<Failure, T>> post<T>(
    String path, {
    required T Function(Response<dynamic> response) responseParser,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return makeRequest<T>(
      () async {
        final response = await _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );

        return responseParser(response);
      },
    );
  }

  /// The method to make http PUT request, which is a alias of [dio.fetch(RequestOptions)].
  Future<Either<Failure, T>> put<T>(
    String path, {
    required T Function(Response<dynamic> response) responseParser,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return makeRequest<T>(
      () async {
        final response = await _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );

        return responseParser(response);
      },
    );
  }

  /// The method to make http PATCH request, which is a alias of [dio.fetch(RequestOptions)].
  Future<Either<Failure, T>> patch<T>(
    String path, {
    required T Function(Response<dynamic> response) responseParser,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return makeRequest<T>(() async {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return responseParser(response);
    });
  }

  /// The method to make http DELETE request, which is a alias of [dio.fetch(RequestOptions)].
  Future<Either<Failure, T>> delete<T>(
    String path, {
    required T Function(Response<dynamic> response) responseParser,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return makeRequest<T>(
      () async {
        final response = await _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );

        return responseParser(response);
      },
    );
  }
}
