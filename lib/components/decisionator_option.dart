import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import '../app/configuration.dart';
import '../app/decisioninator.dart';

class DecisionatorOption extends SpriteComponent
    with HasGameRef<Decisioninator> {
  final String optionImage;
  final int order;

  DecisionatorOption({
    required this.optionImage,
    required this.order,
  });

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(optionImage);
    size = Vector2(480, 150);
    sprite = Sprite(image);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Configuration.attractorSpeed * dt;
  }
}
