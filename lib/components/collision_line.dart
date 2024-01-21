import 'dart:math' as math;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import '../app/assets.dart';
import '../app/decisioninator.dart';

class CollisionLine extends SpriteComponent with HasGameRef<Decisioninator> {
  CollisionLine();

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(Assets.collisionLine);
    size = Vector2(480, 1);
    anchor = Anchor.center;
    angle = math.pi / 2;
    position.y = 240;
    position.x = 287;
    sprite = Sprite(image);
    add(RectangleHitbox());
  }
}
