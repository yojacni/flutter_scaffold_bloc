import 'dart:convert' show json;

import 'package:flutter/services.dart';

import 'entities/enums/flavor_enum.dart';

class AppConfig {
  AppConfig._();

  static final AppConfig instance = AppConfig._();

  dynamic _config;

  String get value => _config['key'] as String;

  Future<void> init(FlavorEnum flavor) async {
    final _jsonStr = await _getConfigJson(flavor);

    _config = json.decode(_jsonStr);
  }

  Future<String> _getConfigJson(FlavorEnum flavor) async {
    try {
      final jsonStr =
          await rootBundle.loadString('app_config_${flavor.name}.json');
      return jsonStr;
    } on Exception catch (_) {
      return '';
    }
  }
}
