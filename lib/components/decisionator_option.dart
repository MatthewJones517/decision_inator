import 'package:decision_inator/components/collision_line.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import '../app/decisioninator.dart';

class DecisionatorOption extends SpriteComponent
    with HasGameRef<Decisioninator>, CollisionCallbacks {
  final String optionImage;
  final int order;
  final int totalOptions;
  bool? collisionEventsTriggered;

  DecisionatorOption({
    required this.optionImage,
    required this.order,
    required this.totalOptions,
  });

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(optionImage);
    size = Vector2(390, 122);
    position.y = (order * 122) - 122;
    position.x = 45;
    sprite = Sprite(image);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += gameRef.spinVelocity! * dt;
    final screenRect = Rect.fromLTWH(0, 0, game.size.x, game.size.y);

    if (position.y > screenRect.bottom) {
      position.y -= 122 * totalOptions;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is CollisionLine && collisionEventsTriggered != true) {
      gameRef.activelySelectedOption = optionImage;
      gameRef.audioPool.start();
      collisionEventsTriggered = true;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is CollisionLine) {
      collisionEventsTriggered = false;
    }
  }
}
