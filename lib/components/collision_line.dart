import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import '../app/assets.dart';
import '../app/decisioninator.dart';

class CollisionLine extends SpriteComponent with HasGameRef<Decisioninator> {
  CollisionLine();

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(Assets.collisionLine);
    size = Vector2(480, 1);
    final screenRect = Rect.fromLTWH(0, 0, game.size.x, game.size.y);
    position.y = (screenRect.height / 2) + 6;
    position.x = 0;
    sprite = Sprite(image);
    add(RectangleHitbox());
  }
}
