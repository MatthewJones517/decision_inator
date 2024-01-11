import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import '../app/decisioninator.dart';

class DecisionatorOption extends SpriteComponent
    with HasGameRef<Decisioninator> {
  final String optionImage;
  final int order;
  final int totalOptions;
  double spinVelocity;

  DecisionatorOption({
    required this.optionImage,
    required this.order,
    required this.totalOptions,
    required this.spinVelocity,
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
    position.y += spinVelocity * dt;
    final screenRect = Rect.fromLTWH(0, 0, game.size.x, game.size.y);

    if (position.y > screenRect.bottom) {
      position.y -= 122 * totalOptions;
    }
  }
}
