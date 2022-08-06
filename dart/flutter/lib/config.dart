import 'dart:developer';

class Config {
  late int height;
  late int width;
  late String aliveStr;
  late String deadStr;
  late int timeout;

  // TODO - learn about short constructor declarations, named parameters and default values
  Config(this.height, this.width, this.aliveStr, this.deadStr, this.timeout);
}

Config initiliazeConfig() {
  log('Trying to read config from config.json');

  log('File config.json not found');

  return initializeDefaultConfig();
}

Config initializeDefaultConfig() {
  int height = 30;
  int width = 60;
  String aliveStr = '+ ';
  String deadStr = ' ';
  int timeout = 100;
  return Config(height, width, aliveStr, deadStr, timeout);
}
