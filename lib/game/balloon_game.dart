import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'player.dart';
import 'spike.dart';
import 'coin.dart';

class BalloonGame extends FlameGame
    with TapDetector, HasCollisionDetection {
  late PlayerBalloon player;
  double spawnTimer = 0;
  final Random rng = Random();
  int score = 0;

  @override
  Future<void> onLoad() async {
    camera.viewport.backgroundColor = Colors.white;
    player = PlayerBalloon(position: size / 2);
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);

    spawnTimer += dt;
    if (spawnTimer > 1.2) {
      spawnTimer = 0;
      _spawnObstacles();
    }
  }

  void _spawnObstacles() {
    final y = -40.0;
    add(Spike(
      position: Vector2(rng.nextDouble() * size.x, y),
    ));

    if (rng.nextBool()) {
      add(Coin(
        position: Vector2(rng.nextDouble() * size.x, y - 60),
        onCollect: () => score++,
      ));
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    player.lift();
  }
}
