import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import '../app/decisioninator.dart';

class ResultBannerContent extends SpriteComponent
    with HasGameRef<Decisioninator> {
  String selectedOption;

  ResultBannerContent(this.selectedOption);

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(selectedOption);
    size = Vector2(460, 144);
    final screenRect = Rect.fromLTWH(0, 0, game.size.x, game.size.y);
    position.y = (screenRect.height / 2) - 25;
    position.x = 10;
    sprite = Sprite(image);
  }
}
