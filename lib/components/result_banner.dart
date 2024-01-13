import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import '../app/assets.dart';
import '../app/decisioninator.dart';

class ResultBanner extends SpriteComponent with HasGameRef<Decisioninator> {
  ResultBanner();

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(Assets.choiceBanner);
    size = Vector2(480, 324);
    final screenRect = Rect.fromLTWH(0, 0, game.size.x, game.size.y);
    position.y = (screenRect.height / 2) - 180;
    position.x = 0;
    sprite = Sprite(image);
  }
}
