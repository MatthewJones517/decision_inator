import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import '../app/decisioninator.dart';

class ResultBannerContent extends SpriteComponent
    with HasGameRef<Decisioninator> {
  ResultBannerContent();

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(gameRef.activelySelectedOption!);
    size = Vector2(480, 150);
    final screenRect = Rect.fromLTWH(0, 0, game.size.x, game.size.y);
    position.y = (screenRect.height / 2) + 20;
    position.x = 0;
    sprite = Sprite(image);
  }
}
