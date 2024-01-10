import 'dart:async';

import 'package:decision_inator/app/assets.dart';
import 'package:decision_inator/components/decisionator_option.dart';
import 'package:flame/game.dart';

class Decisioninator extends FlameGame {
  Decisioninator();

  @override
  FutureOr<void> onLoad() async {
    addAll([
      DecisionatorOption(optionImage: Assets.applebees, order: 0),
      DecisionatorOption(optionImage: Assets.chipotle, order: 1),
      DecisionatorOption(optionImage: Assets.crackerBarrel, order: 2),
      DecisionatorOption(optionImage: Assets.dominos, order: 3),
      DecisionatorOption(optionImage: Assets.ihop, order: 4),
      DecisionatorOption(optionImage: Assets.kfc, order: 5),
      DecisionatorOption(optionImage: Assets.mcdonalds, order: 6),
      DecisionatorOption(optionImage: Assets.oliveGarden, order: 7),
      DecisionatorOption(optionImage: Assets.outback, order: 8),
      DecisionatorOption(optionImage: Assets.paneraBread, order: 9),
      DecisionatorOption(optionImage: Assets.subway, order: 10),
      DecisionatorOption(optionImage: Assets.tacoBell, order: 11),
      DecisionatorOption(optionImage: Assets.texasRoadhouse, order: 12),
    ]);
  }
}
