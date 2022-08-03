import 'dart:math';
import 'dart:io';

void main(List<String> args) {
  const height = 10;
  const width = 10;
  const aliveStr = '+';
  const deadStr = '-';
  const timeout = 100;

  print('The Game Of Life.');

  // Config config = Config(
  //   height: height,
  //   width: width,
  //   aliveStr: aliveStr,
  //   deadStr: deadStr,
  //   timeout: timeout,
  // );

  Config config = Config();
  // Game game = Game(config: config);

  // game.play();

  GameField gameField = GameField(config: config);
  gameField.play();

  print('Game Over.');
}

class Config {
  final int height = 30;
  final int width = 60;
  final String aliveStr = '■ ';
  final String deadStr = '□ ';
  final int timeout = 100;

            // this->aliveStr = "■ ";
            // this->deadStr = "□ ";


  // Config({height, width, aliveStr, deadStr, timeout}) {
  //   this.height = height;
  //   this.width = width;
  //   this.aliveStr = aliveStr;
  //   this.deadStr = deadStr;
  //   this.timeout = timeout;
  // }
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

    // print(point);
  }

  String boolToString(bool point) {
    if (point) {
      return this.config.aliveStr;
    }
    return this.config.deadStr;
  }

  void initialize() {
    final randomNumberGenerator = Random();
    // this.currentGeneration = List<List<bool>>.filled(
    //     this.config.height, List<bool>.filled(this.config.width, false));
    // this.previousGeneration = List<List<bool>>.filled(
    //     this.config.height, List<bool>.filled(this.config.width, false));

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
      // print('\n');
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

  void play() {
    this.initialize();

    int iteration = 0;
    while (true) {
      print('iteration $iteration');

      this.printGeneration();
      this.updateGeneration();

      sleep(Duration(milliseconds: this.config.timeout));

      iteration += 1;
    }
  }
}

// class Game {
//   late final Config config;
//   late GameField gameField;

//   Game({config: Config}) {
//     this.config = config;
//     this.gameField = GameField(config: config);
//   }

//   void play() {
//     this.gameField.initialize();

//     int iteration = 0;
//     while (true) {
//       print(iteration);

//       this.gameField.printGeneration();
//       this.gameField.updateGeneration();

//       sleep(Duration(milliseconds: this.config.timeout));

//       iteration += 1;
//     }
//   }
// }
