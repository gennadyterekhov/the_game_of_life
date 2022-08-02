import 'dart:math';

void main(List<String> args) {
  const height = 10;
  const width = 10;
  const aliveStr = '+';
  const deadStr = '-';
  const timeout = 100;

  print('The Game Of Life.');

  Config config = Config(
    height: height,
    width: width,
    aliveStr: aliveStr,
    deadStr: deadStr,
    timeout: timeout,
  );

  Game game = Game(config: config);

  game.play();

  print('Game Over.');
}

class Config {
  int height = 10;
  int width = 10;
  String aliveStr = '+';
  String deadStr = '-';
  int timeout = 100;

  Config({height, width, aliveStr, deadStr, timeout}) {
    this.height = height;
    this.width = width;
    this.aliveStr = aliveStr;
    this.deadStr = deadStr;
    this.timeout = timeout;
  }
}

class GameField {
  Config config = Config();

  List currentGeneration = [];
  List previousGeneration = [];

  GameField({config}) {
    this.config = config;
  }

  void printPoint(int x, int y) {
    String point = this.boolToString(this.previousGeneration[y][x]);
    print(point);
  }

  String boolToString(bool point) {
    if (point) {
      return this.config.aliveStr;
    }
    return this.config.deadStr;
  }

  void initialize() {
    final randomNumberGenerator = Random();
    this.currentGeneration = List<List<bool>>.filled(
        this.config.height, List<bool>.filled(this.config.width, false));
    this.previousGeneration = List<List<bool>>.filled(
        this.config.height, List<bool>.filled(this.config.width, false));

    for (int i = 0; i < this.config.height; ++i) {
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
      print('\n');
    }
  }

  void updateGeneration() {
    for (int i = 0; i < this.config.height; ++i) {
      for (int j = 0; j < this.config.width; ++j) {
        this.updatePoint(j, i);
      }
    }
  }

  void updatePoint(int x, int y) {
    int aliveNeighbours = this.countAliveNeighbours(x, y);
    bool alive = (this.previousGeneration[y][x] == true);
    bool updatedPoint = ((alive && (aliveNeighbours == 2)) || (aliveNeighbours == 3));

    this.currentGeneration[y][x] = updatedPoint;
  }
}

int countAliveNeighbours(int x, int y) {
  return 0; // TODO implement
}

class Game {
  Config config = Config();
  GameField gameField = GameField();

  Game({config}) {
    this.config = config;
    this.gameField = GameField(config: config);
  }

  void play() {
    this.gameField.initialize();

    int iteration = 0;
    while (true) {
      print(iteration);

      this.gameField.printGeneration();
      this.gameField.updateGeneration();

      iteration += 1;
    }
  }
}
