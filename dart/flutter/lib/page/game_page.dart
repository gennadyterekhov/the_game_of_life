import 'package:flutter/material.dart';
import 'dart:developer';
import '../the_game_of_life/game.dart';
import '../widget/bottom_app_bar.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.title, required this.game})
      : super(key: key);

  final String title;
  final Game game;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String generationString = '';

  @override
  void initState() {
    super.initState();
    generationString = widget.game.gameField.getGenerationString();
  }

  void updateGamePageCallback() {
    log('in updateGamePageCallback');
    log(generationString);

    setState(() {
      generationString = widget.game.gameField.getGenerationString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              generationString,
              style: const TextStyle(fontFamily: 'Noto Sans Mono'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        game: widget.game,
        updateGamePageCallback: updateGamePageCallback,
      ),
    );
  }
}
