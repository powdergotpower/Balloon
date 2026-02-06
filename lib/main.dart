import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game/balloon_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GameWidget(
      game: BalloonGame(),
    ),
  );
}
