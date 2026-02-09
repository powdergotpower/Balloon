import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

import 'balloon_game.dart';      // ← Correct import for HasGameRef<BalloonGame>
import 'spike.dart';
import 'coin.dart';

class PlayerBalloon extends PositionComponent
    with CollisionCallbacks, HasGameRef<BalloonGame> {
  double liftForce = -350.0;
  double gravity = 600.0;
  double velocityY = 0.0;
  late CircleHitbox hitbox;

  PlayerBalloon({required super.position})
      : super(size: Vector2(60, 80), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Visual balloon (simple circles – replace with Sprite if you have assets)
    add(
      CircleComponent(
        radius: size.x / 2 - 5,
        paint: Paint()..color = Colors.blueAccent,
        position: size / 2,
      ),
    );
    add(
      CircleComponent(
        radius: 20,
        paint: Paint()..color = Colors.white.withOpacity(0.6),
        position: Vector2(size.x / 2 + 10, size.y / 2 - 10),
      ),
    );

    // Hitbox for collisions
    hitbox = CircleHitbox()
      ..collisionType = CollisionType.active
      ..isSolid = true;
    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocityY += gravity * dt;
    y += velocityY * dt;

    // Keep on screen
    final gameSize = gameRef.size;
    if (y > gameSize.y - size.y / 2 - 20) {
      y = gameSize.y - size.y / 2 - 20;
      velocityY *= 0.6; // soft landing
    }
    if (y < size.y / 2 + 20) {
      y = size.y / 2 + 20;
      velocityY = max(velocityY, 0);
    }
  }

  void lift() {
    velocityY = liftForce;
  }

  // Correct collision callback signature
  @override
  void onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollision(intersectionPoints, other);

    if (other is Spike) {
      gameRef.pauseEngine(); // Game over
      // Add restart logic or overlay here later
    } else if (other is Coin) {
      other.removeFromParent();
    }
  }
}
