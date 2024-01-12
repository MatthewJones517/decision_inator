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
  int? activeModeIndex;

  late final List<List<DecisionatorOption>> _modes;
  late final Random randomNumberGenerator;

  @override
  FutureOr<void> onLoad() async {
    _machineState = MachineState.attract;
    spinVelocity = Configuration.attractVelocity;
    randomNumberGenerator = Random();
    activeModeIndex = 2;

    final List<DecisionatorOption> dinnerMode = [
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

    final List<DecisionatorOption> choreMode = [
      DecisionatorOption(
        optionImage: Assets.bathroom,
        order: 0,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.cooking,
        order: 1,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.dishes,
        order: 2,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.dusting,
        order: 3,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.groceries,
        order: 4,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.laundry,
        order: 5,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.trash,
        order: 6,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.vacuuming,
        order: 7,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.windowCleaning,
        order: 8,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.yardWork,
        order: 9,
        totalOptions: 10,
      ),
    ];

    final List<DecisionatorOption> dateMode = [
      DecisionatorOption(
        optionImage: Assets.amusementPark,
        order: 0,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.boardGames,
        order: 1,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.comedyClub,
        order: 2,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.karaoke,
        order: 3,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.movie,
        order: 4,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.museum,
        order: 5,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.painting,
        order: 6,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.picnic,
        order: 7,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.triviaNight,
        order: 8,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.walk,
        order: 9,
        totalOptions: 10,
      ),
    ];

    _modes = [
      dinnerMode,
      choreMode,
      dateMode,
    ];

    addAll([
      ..._modes[activeModeIndex!],
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
