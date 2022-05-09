import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import 'environments.dart';

/// Represent configuration reader.
@LazySingleton()
class ConfigReader {
  /// The path where configuration is located.
  static const String configFilePath = 'assets/config.json';

  /// initializing the config.
  Future<void> init() async {
    final configString = await rootBundle.loadString(configFilePath);
    config = json.decode(configString) as Map<String, dynamic>;
  }

  /// App configurations.s
  late final Map<String, dynamic> config;

  /// Getting the base server url.
  String get baseUrl => config['baseUrl'];

  /// Getting the local url.
  String get localHostBaseUrl => config['localHostBaseUrl'];

  /// Getting the app environment.s
  Environments get environment =>
      EnvironmentsX.getEnvironmentFromString(config['environment']);
}
