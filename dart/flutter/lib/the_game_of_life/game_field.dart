import 'config.dart';
import 'dart:math';
// import 'dart:io';

class GameField {
  final Config config;

  List currentGeneration = [];
  List previousGeneration = [];

  GameField({required this.config});

  void printPoint(int x, int y) {
    String point = this.boolToString(this.previousGeneration[y][x]);
    // stdout.write(point);
  }

  String boolToString(bool point) {
    return (point) ? this.config.aliveStr : this.config.deadStr;
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
      // stdout.write('\n');
    }
  }

  String getGenerationString() {
    String gen = '';
    for (int i = 0; i < this.config.height; ++i) {
      for (int j = 0; j < this.config.width; ++j) {
        gen += this.boolToString(this.previousGeneration[i][j]);
      }
      gen += '\n';
    }
    return gen;
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
