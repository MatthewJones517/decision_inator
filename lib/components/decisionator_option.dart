import 'dart:math' as math;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import '../app/decisioninator.dart';
import '../app/machine_state.dart';
import 'collision_line.dart';

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
    size = Vector2(285, 89);
    position.y = 172;
    position.x = (order * 89) - 89;
    anchor = Anchor.center;
    angle = math.pi / 2;
    sprite = Sprite(image);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += gameRef.spinVelocity! * dt;

    if (position.x > 840) {
      position.x -= 89 * totalOptions;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is CollisionLine &&
        collisionEventsTriggered != true &&
        gameRef.machineState == MachineState.spin) {
      gameRef.activelySelectedOption = optionImage;
      gameRef.playClick();
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
