import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'spike.dart';

class PlayerBalloon extends CircleComponent
    with CollisionCallbacks, HasGameRef {
  double velocityY = 0;
  final double gravity = 900;
  final double liftForce = -350;

  PlayerBalloon({required Vector2 position})
      : super(
          position: position,
          radius: 14,
          paint: Paint()..color = Colors.black,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocityY += gravity * dt;
    position.y += velocityY * dt;

    if (position.y < 0 || position.y > gameRef.size.y) {
      gameRef.pauseEngine();
    }
  }

  void lift() {
    velocityY = liftForce;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Spike) {
      gameRef.pauseEngine();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
