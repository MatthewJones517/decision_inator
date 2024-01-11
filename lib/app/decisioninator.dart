import 'dart:async';

import 'package:flame/game.dart';

import '../components/decisionator_option.dart';
import '../components/frame.dart';
import 'assets.dart';
import 'machine_mode.dart';
import 'machine_state.dart';

class Decisioninator extends FlameGame {
  Decisioninator();

  MachineMode? _machineMode;
  MachineState? _machineState;

  late final List<DecisionatorOption> _dinnerOptions;

  @override
  FutureOr<void> onLoad() async {
    _machineMode = MachineMode.dinner;
    _machineState = MachineState.attract;

    _dinnerOptions = [
      DecisionatorOption(
          optionImage: Assets.applebees, order: 0, totalOptions: 13),
      DecisionatorOption(
          optionImage: Assets.chipotle, order: 1, totalOptions: 13),
      DecisionatorOption(
          optionImage: Assets.crackerBarrel, order: 2, totalOptions: 13),
      DecisionatorOption(
          optionImage: Assets.dominos, order: 3, totalOptions: 13),
      DecisionatorOption(optionImage: Assets.ihop, order: 4, totalOptions: 13),
      DecisionatorOption(optionImage: Assets.kfc, order: 5, totalOptions: 13),
      DecisionatorOption(
          optionImage: Assets.mcdonalds, order: 6, totalOptions: 13),
      DecisionatorOption(
          optionImage: Assets.oliveGarden, order: 7, totalOptions: 13),
      DecisionatorOption(
          optionImage: Assets.outback, order: 8, totalOptions: 13),
      DecisionatorOption(
          optionImage: Assets.paneraBread, order: 9, totalOptions: 13),
      DecisionatorOption(
          optionImage: Assets.subway, order: 10, totalOptions: 13),
      DecisionatorOption(
          optionImage: Assets.tacoBell, order: 11, totalOptions: 13),
      DecisionatorOption(
          optionImage: Assets.texasRoadhouse, order: 12, totalOptions: 13),
    ];

    addAll([
      ..._dinnerOptions,
      Frame(),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
