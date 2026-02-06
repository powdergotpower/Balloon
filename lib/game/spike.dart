import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class Spike extends RectangleComponent
    with CollisionCallbacks, HasGameRef {
  Spike({required Vector2 position})
      : super(
          position: position,
          size: Vector2(40, 10),
          paint: Paint()..color = Colors.black,
        );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 120 * dt;

    if (position.y > gameRef.size.y + 50) {
      removeFromParent();
    }
  }
}
