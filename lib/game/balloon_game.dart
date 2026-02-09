import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart'; // Vector2 + more
import 'package:flutter/material.dart';

import 'player.dart';
import 'spike.dart';
import 'coin.dart';

class BalloonGame extends FlameGame
    with HasCollisionDetection, TapCallbacks {
  late PlayerBalloon player;
  double spawnTimer = 0;
  final Random rng = Random();
  int score = 0;

  @override
  Color backgroundColor() => Colors.white;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    player = PlayerBalloon(position: size / 2);
    add(player);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    player.position = gameSize / 2;
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
    const y = -40.0;

    add(
      Spike(
        position: Vector2(
          rng.nextDouble() * size.x,
          y,
        ),
      ),
    );

    if (rng.nextBool()) {
      add(
        Coin(
          position: Vector2(
            rng.nextDouble() * size.x,
            y - 60,
          ),
          onCollect: () => score++,
        ),
      );
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.lift();
  }
}
