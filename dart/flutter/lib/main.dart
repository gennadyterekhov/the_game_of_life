import 'package:flutter/material.dart';
import 'package:the_game_of_life/page/start_menu_page.dart';

const title = 'The Game of Life';

void main(List<String> args) {
  runApp(const MyApp());
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
      home: const StartMenuPage(title: title),
    );
  }
}
