import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

import 'balloon_game.dart';     // ← import the game class
import 'player.dart';           // for PlayerBalloon type

class Coin extends CircleComponent
    with CollisionCallbacks, HasGameRef<BalloonGame> {
  final VoidCallback onCollect;

  Coin({
    required Vector2 position,
    required this.onCollect,
  }) : super(
          position: position,
          radius: 12,                    // bigger = easier to see/collect
          anchor: Anchor.center,
          paint: Paint()..color = Colors.amber,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Add hitbox for collision detection
    add(
      CircleHitbox()
        ..collisionType = CollisionType.passive  // coins don't push back
        ..isSolid = false,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);           // ← IMPORTANT: fixes must_call_super warning

    // Fall down
    position.y += 120 * dt;

    // Remove when off screen
    if (position.y > gameRef.size.y + 50) {
      removeFromParent();
    }
  }

  // Using onCollision (simpler & matches your player code)
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is PlayerBalloon) {
      onCollect();             // increase score
      removeFromParent();      // disappear
    }
  }
}
