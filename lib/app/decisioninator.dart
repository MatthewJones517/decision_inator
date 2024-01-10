import 'dart:async';

import 'package:decision_inator/components/decisionator_option.dart';
import 'package:flame/game.dart';

class Decisioninator extends FlameGame {
  Decisioninator();

  @override
  FutureOr<void> onLoad() async {
    addAll([
      DecisionatorOption()
    ]);
  }
}
