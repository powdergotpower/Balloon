import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'player.dart';

class Coin extends CircleComponent
    with CollisionCallbacks, HasGameRef {
  final VoidCallback onCollect;

  Coin({required Vector2 position, required this.onCollect})
      : super(
          position: position,
          radius: 6,
          paint: Paint()..color = Colors.grey,
        );

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 120 * dt;

    if (position.y > gameRef.size.y + 20) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is PlayerBalloon) {
      onCollect();
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
