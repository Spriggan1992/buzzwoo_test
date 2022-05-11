import 'package:dio/dio.dart';

import '../../../injection.dart';
import 'config_reader.dart';

/// The settings for [Dio] client.
final baseOptions = BaseOptions(
  connectTimeout: 10000,
  receiveTimeout: 10000,
  baseUrl: getIt<ConfigReader>().baseUrl,
  headers: <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  },
);
