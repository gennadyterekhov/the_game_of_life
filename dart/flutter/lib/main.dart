import 'package:flutter/material.dart';
import 'package:the_game_of_life/page/start_menu_page.dart';
import 'page/game_page.dart';
import '../the_game_of_life/game.dart';

const title = 'The Game of Life';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartMenuPage(title: title),
      // home: const GamePage(title: title),
    );
  }
}
