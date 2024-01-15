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
    size = Vector2(480, 324);
    anchor = Anchor.center;
    angle = math.pi / 2;
    position.y = 240;
    position.x = 450;
    sprite = Sprite(image);
  }
}
