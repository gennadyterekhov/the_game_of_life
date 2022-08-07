import 'config.dart';
// import 'dart:io';
import 'game_field.dart';
import 'dart:developer';

class Game {
  final Config config;
  late GameField gameField;

  Game({required this.config}) {
    this.gameField = GameField(config: config);
  }

  void play() {
    this.gameField.initialize();

    int iteration = 0;
    while (true) {
      log('iteration $iteration');

      this.gameField.printGeneration();
      this.gameField.updateGeneration();

      // sleep(Duration(milliseconds: this.config.timeout));

      iteration += 1;
    }
  }
}

Game initializeGame() {
  Config config = initiliazeConfig();

  Game game = Game(config: config);
  game.gameField.initialize();

  return game;
}
