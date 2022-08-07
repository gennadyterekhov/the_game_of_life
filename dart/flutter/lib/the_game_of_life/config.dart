class Config {
  int height;
  int width;
  String aliveStr;
  String deadStr;
  int timeout;

  Config(
      {required this.height,
      required this.width,
      required this.aliveStr,
      required this.deadStr,
      required this.timeout});
}

Config initiliazeConfig() {
  return initializeDefaultConfig();
}

Config initializeDefaultConfig() {
  int height = 30;
  int width = 60;
  String aliveStr = '■ ';
  String deadStr = '□ ';
  int timeout = 400;
  return Config(
      height: height,
      width: width,
      aliveStr: aliveStr,
      deadStr: deadStr,
      timeout: timeout);
}
