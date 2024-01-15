import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import '../app/assets.dart';
import '../app/decisioninator.dart';

class Frame extends SpriteComponent with HasGameRef<Decisioninator> {
  Frame();

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(Assets.frame);
    size = Vector2(480, 800);
    anchor = Anchor.center;
    angle = math.pi / 2;
    position = Vector2(400, 240);
    sprite = Sprite(image);
  }
}
