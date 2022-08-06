import 'dart:convert';
import 'dart:io';
import 'dart:developer';

class Config {
  late int height;
  late int width;
  late String aliveStr;
  late String deadStr;
  late int timeout;

  // TODO - learn about short constructor declarations, named parameters and default values
  Config(int height, int width, String aliveStr, String deadStr, int timeout) {
    this.height = height;
    this.width = width;
    this.aliveStr = aliveStr;
    this.deadStr = deadStr;
    this.timeout = timeout;
  }
}

Config initiliazeConfig() {
  log('Trying to read config from config.json');

  File configFile = File('config.json');

  if (configFile.existsSync()) {
    return initializeConfigFromFile(configFile);
  }

  log('File config.json not found');

  return initializeDefaultConfig();
}

Config initializeConfigFromFile(File configFile) {
  late int height;
  late int width;
  late String aliveStr;
  late String deadStr;
  late int timeout;

  String configJsonString = configFile.readAsStringSync();

  Map<String, dynamic> configMap = jsonDecode(configJsonString);

  configMap.containsKey('heigth');

  if (configMap.containsKey('height') && configMap['height'] is int) {
    height = configMap['height'];
  } else {
    throwConfigError('height', 'int');
  }

  if (configMap.containsKey('width') && configMap['width'] is int) {
    width = configMap['width'];
  } else {
    throwConfigError('width', 'int');
  }

  if (configMap.containsKey('alive') && configMap['alive'] is String) {
    aliveStr = configMap['alive'];
  } else {
    throwConfigError('alive', 'String');
  }

  if (configMap.containsKey('dead') && configMap['dead'] is String) {
    deadStr = configMap['dead'];
  } else {
    throwConfigError('dead', 'String');
  }

  if (configMap.containsKey('timeout') && configMap['timeout'] is int) {
    timeout = configMap['timeout'];
  } else {
    throwConfigError('timeout', 'int');
  }
  return Config(height, width, aliveStr, deadStr, timeout);
}

void throwConfigError(String fieldName, String type) {
  throw Exception(
      'field $fieldName not found or of incompatible type. Type $type expected.');
}

Config initializeDefaultConfig() {
  int height = 30;
  int width = 60;
  String aliveStr = '■ ';
  String deadStr = '□ ';
  int timeout = 100;
  return Config(height, width, aliveStr, deadStr, timeout);
}
