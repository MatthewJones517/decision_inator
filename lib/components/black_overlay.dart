import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BlackOverlay extends PositionComponent {
  late final Rect gameRect;

  BlackOverlay(this.gameRect);

  @override
  void render(Canvas canvas) {
    final paint = Paint();
    paint.color = const Color.fromRGBO(0, 0, 0, 0.7); // Black with 70% opacity

    canvas.drawRect(gameRect, paint);
  }
}
