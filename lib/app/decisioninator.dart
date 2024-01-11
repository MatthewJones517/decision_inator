import 'dart:async';
import 'dart:math';

import 'package:decision_inator/app/configuration.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';

import '../components/decisionator_option.dart';
import '../components/frame.dart';
import 'assets.dart';
import 'machine_state.dart';

class Decisioninator extends FlameGame with TapDetector {
  Decisioninator();

  MachineState? _machineState;
  double? _spinVelocity;

  late final List<DecisionatorOption> _dinnerOptions;
  late final Random randomNumberGenerator;

  @override
  FutureOr<void> onLoad() async {
    _machineState = MachineState.attract;
    _spinVelocity = Configuration.attractVelocity;
    randomNumberGenerator = Random();

    _dinnerOptions = [
      DecisionatorOption(
        optionImage: Assets.applebees,
        order: 0,
        totalOptions: 13,
        spinVelocity: _spinVelocity!,
      ),
      DecisionatorOption(
          optionImage: Assets.chipotle,
          order: 1,
          totalOptions: 13,
          spinVelocity: _spinVelocity!),
      DecisionatorOption(
          optionImage: Assets.crackerBarrel,
          order: 2,
          totalOptions: 13,
          spinVelocity: _spinVelocity!),
      DecisionatorOption(
          optionImage: Assets.dominos,
          order: 3,
          totalOptions: 13,
          spinVelocity: _spinVelocity!),
      DecisionatorOption(
          optionImage: Assets.ihop,
          order: 4,
          totalOptions: 13,
          spinVelocity: _spinVelocity!),
      DecisionatorOption(
          optionImage: Assets.kfc,
          order: 5,
          totalOptions: 13,
          spinVelocity: _spinVelocity!),
      DecisionatorOption(
          optionImage: Assets.mcdonalds,
          order: 6,
          totalOptions: 13,
          spinVelocity: _spinVelocity!),
      DecisionatorOption(
          optionImage: Assets.oliveGarden,
          order: 7,
          totalOptions: 13,
          spinVelocity: _spinVelocity!),
      DecisionatorOption(
          optionImage: Assets.outback,
          order: 8,
          totalOptions: 13,
          spinVelocity: _spinVelocity!),
      DecisionatorOption(
          optionImage: Assets.paneraBread,
          order: 9,
          totalOptions: 13,
          spinVelocity: _spinVelocity!),
      DecisionatorOption(
          optionImage: Assets.subway,
          order: 10,
          totalOptions: 13,
          spinVelocity: _spinVelocity!),
      DecisionatorOption(
          optionImage: Assets.tacoBell,
          order: 11,
          totalOptions: 13,
          spinVelocity: _spinVelocity!),
      DecisionatorOption(
          optionImage: Assets.texasRoadhouse,
          order: 12,
          totalOptions: 13,
          spinVelocity: _spinVelocity!),
    ];

    addAll([
      ..._dinnerOptions,
      Frame(),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    double newSpinVelocity;

    switch (_machineState) {
      case null:
      case MachineState.attract:
        newSpinVelocity = Configuration.attractVelocity;
        break;
      case MachineState.spin:
        newSpinVelocity = _spinVelocity! - Configuration.spinFriction;
        break;
      case MachineState.result:
        newSpinVelocity = Configuration.spinResultSpeed;
        break;
    }

    if (newSpinVelocity < Configuration.minimumSpeedToBeConsideredSpinning) {
      _machineState = MachineState.result;
      newSpinVelocity = Configuration.spinResultSpeed;
    }

    if (newSpinVelocity != _spinVelocity) {
      _spinVelocity = newSpinVelocity;
      for (var element in _dinnerOptions) {
        element.spinVelocity = newSpinVelocity;
      }
    }
  }

  @override
  void onTap() {
    super.onTap();
    if (_machineState != MachineState.spin) {
      _startSpin();
    }
  }

  void _startSpin() {
    _spinVelocity =
        Configuration.spinBaseSpeed + randomNumberGenerator.nextInt(100) + 1;
    _machineState = MachineState.spin;
  }
}
