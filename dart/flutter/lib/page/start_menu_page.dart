import 'package:flutter/material.dart';
import 'package:the_game_of_life/page/game_page.dart';
import 'dart:developer';
import '../the_game_of_life/game.dart';
import '../the_game_of_life/config.dart';
import 'dart:convert';

//android_sdk/cmdline-tools/latest/bin/sdkmanager --install "cmdline-tools;version"
//  /Users/gena/Library/Android/sdk/cmdline-tools/latest/bin/sdkmanager --install "cmdline-tools;latest"
class StartMenuPage extends StatefulWidget {
  const StartMenuPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StartMenuPage> createState() => _StartMenuPageState();
}

class _StartMenuPageState extends State<StartMenuPage> {
  late TextEditingController _heightInputController;
  late TextEditingController _widthInputController;
  late TextEditingController _aliveStrInputController;
  late TextEditingController _deadStrInputController;
  late TextEditingController _timeoutInputController;

/**
 * iPhone 7 plus size:
 * height: 736.0
 * width: 414.0
 * 
 * 
 * mac air 13 size:
 * height: 796.0
 * width: 1440.0
 * 
 * 
 * 
 */
  @override
  void initState() {
    super.initState();
    // здесь нужно как-то взять дефолты в зависимости от устройства

    // double height = (MediaQuery.of(context).size.height);
    // double width = MediaQuery.of(context).size.width;

    // log('height $height');
    // log('width $width');

    _heightInputController =
        TextEditingController(text: '30'); // optimal for iphone 7 plus
    _widthInputController =
        TextEditingController(text: '20'); // // optimal for iphone 7 plus
    _aliveStrInputController = TextEditingController(text: '+ ');
    _deadStrInputController = TextEditingController(text: '- ');
    _timeoutInputController = TextEditingController(text: '200');
  }

  @override
  void dispose() {
    _heightInputController.dispose();
    _widthInputController.dispose();
    _aliveStrInputController.dispose();
    _deadStrInputController.dispose();
    _timeoutInputController.dispose();

    super.dispose();
  }

  void onStartGameBtnPressed() {
    log('inside onStartGameBtnPressed');
    var data = [
      _heightInputController.value,
      _widthInputController.value,
      _aliveStrInputController.value,
      _deadStrInputController.value,
      _timeoutInputController.value,
    ];
    log('$data');

    // Game game = initializeGame();
    Config config = Config(
      height: int.parse(_heightInputController.text),
      width: int.parse(_widthInputController.text),
      aliveStr: (_aliveStrInputController.text),
      deadStr: (_deadStrInputController.text),
      timeout: int.parse(_timeoutInputController.text),
    );
    Game game = Game(config: config);
    game.gameField.initialize();

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
        // widthFactor: 0.5,
        child: Container(
          height: (MediaQuery.of(context).size.height),
          width: (MediaQuery.of(context).size.width),
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to the game of life',
                style: TextStyle(fontFamily: 'Noto Sans Mono'),
              ),
              // Text(
              //   'height: ${MediaQuery.of(context).size.height}',
              // ),
              // Text(
              //   'width: ${MediaQuery.of(context).size.width}',
              // ),
              TextField(
                controller: _heightInputController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Game field height'),
              ),
              TextField(
                controller: _widthInputController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Game field width'),
              ),
              TextField(
                controller: _aliveStrInputController,
                decoration: const InputDecoration(
                    labelText: 'String to represent alive cells'),
              ),
              TextField(
                controller: _deadStrInputController,
                decoration: const InputDecoration(
                    labelText: 'String to represent dead cells'),
              ),
              TextField(
                controller: _timeoutInputController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Wait time between generations in milliseconds'),
              ),
              // Row(
              //   children: <Widget>[
              //     Container(
              //       width: 200,
              //       child: TextField(
              //         controller: _heightInputController,
              //         keyboardType: TextInputType.number,
              //         decoration:
              //             const InputDecoration(labelText: 'Game field height'),
              //       ),
              //     ),
              //     Container(
              //       width: 200,
              //       child: TextField(
              //         controller: _widthInputController,
              //         keyboardType: TextInputType.number,
              //         decoration:
              //             const InputDecoration(labelText: 'Game field width'),
              //       ),
              //     )
              //   ],
              // ),
              // Row(
              //   children: <Widget>[
              //     TextField(
              //       controller: _aliveStrInputController,
              //       decoration: const InputDecoration(
              //           labelText: 'String to represent alive cells'),
              //     ),
              //     TextField(
              //       controller: _deadStrInputController,
              //       decoration: const InputDecoration(
              //           labelText: 'String to represent dead cells'),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: <Widget>[
              //     TextField(
              //       controller: _timeoutInputController,
              //       keyboardType: TextInputType.number,
              //       decoration: const InputDecoration(
              //           labelText:
              //               'Wait time between generations in milliseconds'),
              //     ),
              //   ],
              // ),
              TextButton(
                  onPressed: onStartGameBtnPressed,
                  child: const Text('Start game')),
            ],
          ),
        ),
      ),
    );
  }
}
