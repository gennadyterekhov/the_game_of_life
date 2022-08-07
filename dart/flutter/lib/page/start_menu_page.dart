import 'package:flutter/material.dart';
import 'package:the_game_of_life/page/game_page.dart';
import 'dart:developer';
import '../the_game_of_life/game.dart';

class StartMenuPage extends StatefulWidget {
  const StartMenuPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StartMenuPage> createState() => _StartMenuPageState();
}

class _StartMenuPageState extends State<StartMenuPage> {
  void onStartGameBtnPressed() {
    log('inside onStartGameBtnPressed');

    Game game = initializeGame();

    openGamePage(game);
  }

  void openGamePage(Game game) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) {
        return GamePage(
          title: widget.title,
          game: game,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO - add config
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the game of life',
              style: TextStyle(fontFamily: 'Noto Sans Mono'),
            ),
            TextButton(
                onPressed: onStartGameBtnPressed,
                child: const Text('Start game')),
          ],
        ),
      ),
    );
  }
}
