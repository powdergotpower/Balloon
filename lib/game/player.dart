import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

// Assuming this is your player component
// Replace the body with your actual player logic (circle, sprite, physics, etc.)
class PlayerBalloon extends PositionComponent
    with HasGameRef<BalloonGame> {
  // Example properties – adjust to your needs
  double liftForce = -250.0; // upward force when tapped
  double gravity = 400.0;
  double velocityY = 0.0;

  PlayerBalloon({required Vector2 position})
      : super(position: position, size: Vector2(60, 80), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Example: add a simple circle shape (replace with SpriteComponent if using image)
    add(
      CircleComponent(
        radius: 30,
        paint: Paint()..color = Colors.blue,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Simple gravity + velocity
    velocityY += gravity * dt;
    position.y += velocityY * dt;

    // Optional: keep player within screen bounds
    if (position.y > gameRef.size.y - 40) {
      position.y = gameRef.size.y - 40;
      velocityY = 0;
    }
    if (position.y < 40) {
      position.y = 40;
      velocityY = 0;
    }
  }

  void lift() {
    velocityY = liftForce; // jump/lift up on tap
  }

  // Optional: collision handling example
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Spike) {
      // Game over logic
      gameRef.pauseEngine();
      // or show overlay, etc.
    } else if (other is Coin) {
      other.removeFromParent(); // collect coin
      // score++ is handled in Coin's onCollect callback
    }
  }
}
