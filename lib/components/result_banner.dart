import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import '../app/assets.dart';
import '../app/decisioninator.dart';

class ResultBanner extends SpriteComponent with HasGameRef<Decisioninator> {
  ResultBanner();

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(Assets.choiceBanner);
    size = Vector2(353, 238);
    anchor = Anchor.center;
    angle = math.pi / 2;
    position.y = 176.5;
    position.x = 320;
    sprite = Sprite(image);
  }
}
