import 'config.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  late BaseConfig config;

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = 'DEV';
  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';


  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      default:
        return DevConfig();
    }
  }
}