import 'dart:math';
import 'dart:io';
import 'dart:convert';

Game initizlizeGame() {
  Config config = initiliazeConfig();

  Game game = Game(config: config);

  return game;
}

Config initiliazeConfig() {

  File configFile = File('config.json');

  if (configFile.existsSync()) {
    return initializeConfigFromFile(configFile);
  } else {
    return initializeDefaultConfig();
  }
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

class Config {
  late int height;
  late int width;
  late String aliveStr;
  late String deadStr;
  late int timeout;

  Config(int height, int width, String aliveStr, String deadStr, int timeout) {
    this.height = height;
    this.width = width;
    this.aliveStr = aliveStr;
    this.deadStr = deadStr;
    this.timeout = timeout;
  }
}

class GameField {
  late final Config config;

  List currentGeneration = [];
  List previousGeneration = [];

  GameField({config: Config}) {
    this.config = config;
  }

  void printPoint(int x, int y) {
    String point = this.boolToString(this.previousGeneration[y][x]);
    stdout.write(point);
  }

  String boolToString(bool point) {
    if (point) {
      return this.config.aliveStr;
    }
    return this.config.deadStr;
  }

  void initialize() {
    final randomNumberGenerator = Random();

    this.currentGeneration =
        List<List<bool>>.filled(this.config.height, List<bool>.empty());
    this.previousGeneration =
        List<List<bool>>.filled(this.config.height, List<bool>.empty());

    for (int i = 0; i < this.config.height; ++i) {
      this.currentGeneration[i] = List<bool>.filled(this.config.width, false);
      this.previousGeneration[i] = List<bool>.filled(this.config.width, false);

      for (int j = 0; j < this.config.width; ++j) {
        final randomBoolean = randomNumberGenerator.nextBool();

        this.currentGeneration[i][j] = randomBoolean;
        this.previousGeneration[i][j] = randomBoolean;
      }
    }
  }

  void printGeneration() {
    for (int i = 0; i < this.config.height; ++i) {
      for (int j = 0; j < this.config.width; ++j) {
        this.printPoint(j, i);
      }
      stdout.write('\n');
    }
  }

  void updateGeneration() {
    for (int i = 0; i < this.config.height; ++i) {
      for (int j = 0; j < this.config.width; ++j) {
        this.updatePoint(j, i);
      }
    }
    for (int i = 0; i < this.config.height; ++i) {
      for (int j = 0; j < this.config.width; ++j) {
        this.previousGeneration[i][j] = this.currentGeneration[i][j];
      }
    }
  }

  void updatePoint(int x, int y) {
    int aliveNeighbours = this.countAliveNeighbours(x, y);
    bool alive = (this.previousGeneration[y][x] == true);
    bool updatedPoint =
        ((alive && (aliveNeighbours == 2)) || (aliveNeighbours == 3));

    this.currentGeneration[y][x] = updatedPoint;
  }

  int countAliveNeighbours(int x, int y) {
    int aliveCount = 0;
    for (int i = y - 1; ((i <= y + 1) && (i < this.config.height)); i++) {
      for (int j = x - 1; ((j <= x + 1) && (j < this.config.width)); j++) {
        if (i >= 0 && j >= 0 && (i != y || j != x)) {
          aliveCount += (this.previousGeneration[i][j]) ? 1 : 0;
        }
      }
    }
    return aliveCount;
  }
}

class Game {
  late final Config config;
  late GameField gameField;

  Game({config: Config}) {
    this.config = config;
    this.gameField = GameField(config: config);
  }

  void play() {
    this.gameField.initialize();

    int iteration = 0;
    while (true) {
      print('iteration $iteration');

      this.gameField.printGeneration();
      this.gameField.updateGeneration();

      sleep(Duration(milliseconds: this.config.timeout));

      iteration += 1;
    }
  }
}
