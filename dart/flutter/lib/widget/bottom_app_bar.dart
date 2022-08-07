import 'package:flutter/material.dart';
import 'dart:developer';
import '../the_game_of_life/game.dart';

class MyBottomAppBar extends StatefulWidget {
  const MyBottomAppBar({
    Key? key,
    required this.game,
    required this.updateGamePageCallback,
  }) : super(key: key);

  final Game game;

  final Function updateGamePageCallback;
  @override
  State<MyBottomAppBar> createState() => MyBottomAppBarState();
}

class MyBottomAppBarState extends State<MyBottomAppBar> {
  void _onMenuPressed() {
    log('menu pressed');
  }

  void _onNextGenerationPressed() {
    log('_onNextGenerationPressed');

    // String newGameFieldString = game.gameField.getGenerationString();
    // log(_gameFieldString);
    widget.game.gameField.updateGeneration();

    widget.updateGamePageCallback();
    setState(() {
      // widget.game.gameField.updateGeneration();
      // _gameFieldString = newGameFieldString;
    });
  }

  void _onPausePressed() {
    log('_onPausePressed');
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: null,
      color: Colors.blue,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Open Menu',
              icon: const Icon(Icons.menu),
              onPressed: _onMenuPressed,
            ),
            const Spacer(),
            IconButton(
              tooltip: 'Pause',
              icon: const Icon(Icons.pause),
              onPressed: _onPausePressed,
            ),
            const Spacer(),
            IconButton(
              tooltip: 'Next Generation',
              icon: const Icon(Icons.arrow_forward),
              onPressed: _onNextGenerationPressed,
            ),
          ],
        ),
      ),
    );
  }
}
