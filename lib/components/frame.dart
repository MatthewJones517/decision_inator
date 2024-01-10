import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import '../app/assets.dart';
import '../app/decisioninator.dart';

class Frame extends SpriteComponent with HasGameRef<Decisioninator> {
  Frame();

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(Assets.frame);
    final screenRect = Rect.fromLTWH(0, 0, game.size.x, game.size.y);
    size = Vector2(480, screenRect.height);
    sprite = Sprite(image);
  }
}
