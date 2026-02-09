import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game/balloon_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      home: GamePage(),
    ),
  );
}

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: BalloonGame(),
      ),
    );
  }
}
