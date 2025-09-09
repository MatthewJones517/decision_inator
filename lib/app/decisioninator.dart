import 'dart:async';
import 'dart:math';

import 'package:decision_inator/components/result_banner_content.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gpiod/flutter_gpiod.dart';

import '../components/black_overlay.dart';
import '../components/collision_line.dart';
import '../components/decisionator_option.dart';
import '../components/frame.dart';
import '../components/result_banner.dart';
import 'assets.dart';
import 'configuration.dart';
import 'machine_state.dart';

class Decisioninator extends FlameGame
    with TapDetector, KeyboardEvents, HasCollisionDetection {
  Decisioninator();

  MachineState? machineState;
  double? spinVelocity;
  int? activeModeIndex;
  String? activelySelectedOption;
  bool spinComplete = false;
  bool modeDebounceActive = false;

  // Turn off for testing
  bool gpioEnabled = false;

  late final List<List<DecisionatorOption>> _modes;
  late final Random randomNumberGenerator;
  late final Frame frame;
  late final CollisionLine collisionLine;
  late final ResultBanner resultBanner;
  ResultBannerContent? resultBannerContent;
  late final BlackOverlay blackOverlay;
  late final AudioPool clickPool;
  late final AudioPool fanfarePool;

  @override
  FutureOr<void> onLoad() async {
    final screenRect = Rect.fromLTWH(0, 0, size.x, size.y);

    machineState = MachineState.loading;
    spinVelocity = Configuration.spinLoadingSpeed;
    randomNumberGenerator = Random();
    activeModeIndex = 0;
    frame = Frame();
    collisionLine = CollisionLine();
    resultBanner = ResultBanner();
    blackOverlay = BlackOverlay(screenRect);

    await FlameAudio.audioCache.load(Assets.click);
    await FlameAudio.audioCache.load(Assets.fanfare);

    clickPool = await FlameAudio.createPool(
      Assets.click,
      minPlayers: 3,
      maxPlayers: 4,
    );

    fanfarePool = await FlameAudio.createPool(
      Assets.fanfare,
      minPlayers: 1,
      maxPlayers: 2,
    );

    _modes = _loadModes();

    if (gpioEnabled) {
      final chips = FlutterGpiod.instance.chips;

      final chip = chips.singleWhere(
        (chip) => chip.label == 'pinctrl-bcm2711',
        orElse: () =>
            chips.singleWhere((chip) => chip.label == 'pinctrl-bcm2835'),
      );

      final GpioLine spinButtonLine =
          chip.lines[Configuration.spinButtonGpioPin];
      _setUpButton(spinButtonLine, _startSpin);

      final GpioLine modeButtonLine =
          chip.lines[Configuration.modeButtonGpioPin];
      _setUpButton(modeButtonLine, _switchMode);
    }

    await addAll([
      ..._modes[activeModeIndex!],
      frame,
      collisionLine,
    ]);

    machineState = MachineState.attract;
    spinVelocity = Configuration.attractVelocity;
  }

  @override
  void update(double dt) {
    super.update(dt);

    double newSpinVelocity;

    switch (machineState) {
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
      case MachineState.loading:
        newSpinVelocity = Configuration.spinLoadingSpeed;
    }

    if (newSpinVelocity < Configuration.minimumSpeedToBeConsideredSpinning &&
        machineState != MachineState.loading) {
      _showResult();
      newSpinVelocity = Configuration.spinResultSpeed;
    }

    if (newSpinVelocity != spinVelocity) {
      spinVelocity = newSpinVelocity;
    }
  }

  void _showResult() {
    if (!spinComplete) {
      machineState = MachineState.result;

      fanfarePool.start();
      resultBannerContent = ResultBannerContent(activelySelectedOption!);
      addAll([
        blackOverlay,
        resultBannerContent!,
        resultBanner,
      ]);
      spinComplete = true;

      Future.delayed(const Duration(seconds: 5), () {
        machineState = MachineState.attract;
        removeAll([
          blackOverlay,
          resultBannerContent!,
          resultBanner,
        ]);
        spinComplete = false;
      });
    }
  }

  List<List<DecisionatorOption>> _loadModes() {
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

    final List<DecisionatorOption> streamingMode = [
      DecisionatorOption(
        optionImage: Assets.appleTV,
        order: 0,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.crunchyroll,
        order: 1,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.disneyPlus,
        order: 2,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.hboMax,
        order: 3,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.hulu,
        order: 4,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.netflix,
        order: 5,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.paramount,
        order: 6,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.peacock,
        order: 7,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.primeVideo,
        order: 8,
        totalOptions: 10,
      ),
      DecisionatorOption(
        optionImage: Assets.youTube,
        order: 9,
        totalOptions: 10,
      ),
    ];

    return [
      dinnerMode,
      choreMode,
      dateMode,
      streamingMode,
    ];
  }

  void _switchMode() async {
    if (machineState == MachineState.attract && !modeDebounceActive) {
      modeDebounceActive = true;
      machineState == MachineState.loading;
      spinVelocity = Configuration.spinLoadingSpeed;

      removeAll([
        ..._modes[activeModeIndex!],
        frame,
        collisionLine,
      ]);

      if (activeModeIndex! + 1 == _modes.length) {
        activeModeIndex = 0;
      } else {
        activeModeIndex = activeModeIndex! + 1;
      }

      await addAll([
        ..._modes[activeModeIndex!],
        frame,
        collisionLine,
      ]);

      await Future.delayed(const Duration(milliseconds: 500), () {
        modeDebounceActive = false;
      });

      machineState == MachineState.attract;
    }
  }

  void _startSpin() {
    if (machineState == MachineState.attract) {
      spinVelocity =
          Configuration.spinBaseSpeed + randomNumberGenerator.nextInt(150) + 1;
      machineState = MachineState.spin;
    }
  }

  void _setUpButton(GpioLine line, Function onPush) {
    line.requestInput(
        consumer: line.toString(),
        triggers: {
          SignalEdge.falling,
          SignalEdge.rising,
        },
        bias: Bias.pullUp);

    line.onEvent.listen((event) {
      if (event.edge == SignalEdge.rising) {
        onPush();
      }
    });
  }

  void playClick() {
    clickPool.start();
  }
}
