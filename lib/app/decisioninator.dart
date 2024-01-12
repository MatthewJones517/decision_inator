import 'dart:async';
import 'dart:math';

import 'package:decision_inator/app/configuration.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../components/decisionator_option.dart';
import '../components/frame.dart';
import 'assets.dart';
import 'machine_state.dart';

class Decisioninator extends FlameGame with TapDetector, KeyboardEvents {
  Decisioninator();

  MachineState? _machineState;
  double? spinVelocity;

  late final List<DecisionatorOption> _dinnerOptions;
  late final Random randomNumberGenerator;

  @override
  FutureOr<void> onLoad() async {
    _machineState = MachineState.attract;
    spinVelocity = Configuration.attractVelocity;
    randomNumberGenerator = Random();

    _dinnerOptions = [
      DecisionatorOption(
        optionImage: Assets.applebees,
        order: 0,
        totalOptions: 13,
      ),
      DecisionatorOption(
        optionImage: Assets.chipotle,
        order: 1,
        totalOptions: 13,
      ),
      DecisionatorOption(
        optionImage: Assets.crackerBarrel,
        order: 2,
        totalOptions: 13,
      ),
      DecisionatorOption(
        optionImage: Assets.dominos,
        order: 3,
        totalOptions: 13,
      ),
      DecisionatorOption(
        optionImage: Assets.ihop,
        order: 4,
        totalOptions: 13,
      ),
      DecisionatorOption(
        optionImage: Assets.kfc,
        order: 5,
        totalOptions: 13,
      ),
      DecisionatorOption(
        optionImage: Assets.mcdonalds,
        order: 6,
        totalOptions: 13,
      ),
      DecisionatorOption(
        optionImage: Assets.oliveGarden,
        order: 7,
        totalOptions: 13,
      ),
      DecisionatorOption(
        optionImage: Assets.outback,
        order: 8,
        totalOptions: 13,
      ),
      DecisionatorOption(
        optionImage: Assets.paneraBread,
        order: 9,
        totalOptions: 13,
      ),
      DecisionatorOption(
        optionImage: Assets.subway,
        order: 10,
        totalOptions: 13,
      ),
      DecisionatorOption(
        optionImage: Assets.tacoBell,
        order: 11,
        totalOptions: 13,
      ),
      DecisionatorOption(
        optionImage: Assets.texasRoadhouse,
        order: 12,
        totalOptions: 13,
      ),
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
        newSpinVelocity = spinVelocity! - Configuration.spinFriction;
        break;
      case MachineState.result:
        newSpinVelocity = Configuration.spinResultSpeed;
        break;
    }

    if (newSpinVelocity < Configuration.minimumSpeedToBeConsideredSpinning) {
      _machineState = MachineState.result;
      newSpinVelocity = Configuration.spinResultSpeed;
    }

    if (newSpinVelocity != spinVelocity) {
      spinVelocity = newSpinVelocity;
    }
  }

  @override
  void onTap() {
    super.onTap();
    if (_machineState != MachineState.spin) {
      _startSpin();
    }
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSpace && isKeyDown) {
      if (_machineState != MachineState.spin) {
        _startSpin();
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void _startSpin() {
    spinVelocity =
        Configuration.spinBaseSpeed + randomNumberGenerator.nextInt(100) + 1;
    _machineState = MachineState.spin;
  }
}
