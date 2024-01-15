import 'dart:math' as math;
import 'package:flame/components.dart';
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
    anchor = Anchor.center;
    angle = math.pi / 2;
    position.y = 235;
    position.x = 385;
    sprite = Sprite(image);
  }
}
