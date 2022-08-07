import 'package:flutter/material.dart';
import 'dart:developer';
import '../the_game_of_life/game.dart';
import 'dart:async';

class MyBottomAppBar extends StatefulWidget {
  const MyBottomAppBar({
    Key? key,
    required this.game,
    required this.updateGamePageCallback,
  }) : super(key: key);

  final Game game;
  final myNumber = 5;

  final Function updateGamePageCallback;
  @override
  State<MyBottomAppBar> createState() => MyBottomAppBarState();
}

class MyBottomAppBarState extends State<MyBottomAppBar> {
  bool isPaused = true;
  void _onMenuPressed() {
    log('menu pressed');
    // TODO implement - add change config (but how - it is designed to be final? (redesign lol))

    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) {
        return Drawer(
          child: ListView(
            // padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Menu'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              ListTile(
                title: const Text('Close'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    ));
  }

  late final Timer nextGenerationSleepTimer;

  @override
  void initState() {
    nextGenerationSleepTimer = Timer.periodic(
        Duration(milliseconds: widget.game.config.timeout), onTimer);
    super.initState();
  }

  void onTimer(timer) {
    if (!isPaused) {
      updateGeneration();
    }
  }

  void updateGeneration() {
    widget.game.gameField.updateGeneration();

    widget.updateGamePageCallback();
  }

  void _onNextGenerationPressed() {
    if (!isPaused) {
      log('cannot get next generation when not paused');

      return;
    }

    log('_onNextGenerationPressed');

    updateGeneration();
  }

  void _onPausePressed() {
    setState(() {
      isPaused = !isPaused;
    });
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
              tooltip: isPaused ? 'Play' : 'Pause',
              icon: isPaused
                  ? const Icon(Icons.play_arrow)
                  : const Icon(Icons.pause),
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
