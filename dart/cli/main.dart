import 'config.dart';
import 'game.dart';

void main(List<String> args) {
  try {
    theGameOfLife();
  } catch (exception) {
    print('An error orurred. Message: $exception');
  }
}

void theGameOfLife() {
  print('The Game Of Life.');

  Config config = initiliazeConfig();

  Game game = Game(config: config);

  game.play();

  print('Game Over.');
}
