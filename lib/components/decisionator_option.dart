import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import '../app/decisioninator.dart';

class DecisionatorOption extends SpriteComponent with HasGameRef<Decisioninator> {

  DecisionatorOption();

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load('restaurants/Applebees.png');
    size = Vector2(480, 150);
    sprite = Sprite(image);
    add(RectangleHitbox());
  }
}