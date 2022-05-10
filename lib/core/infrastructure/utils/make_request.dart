import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../home/core/domain/exceptions/local_storage_exception.dart';
import '../../domain/failure.dart';
import '../extensions/dio_extensions.dart';

/// The callback request
typedef CallBackRequest<T> = Future<T> Function();

/// Make http request.
Future<Either<Failure, T>> makeRequest<T>(
  CallBackRequest callback,
) async {
  try {
    final response = await callback();
    log('$response', name: 'success_response');

    return right(response as T);
  } on DioError catch (e) {
    log('${e.message}: ${e.type}; response: ${e.response}', level: 2);
    if (e.isNoConnectionError) {
      log('${e.message}: ${e.type}', level: 2);

      return left(const Failure.noConnection());
    } else {
      log('${e.message}: ${e.type}', level: 2);

      return left(const Failure.api());
    }
  } on LocalStorageException catch (_) {
    return left(const Failure.api());
  } catch (e) {
    log(e.toString());

    return left(const Failure.api());
  }
}
