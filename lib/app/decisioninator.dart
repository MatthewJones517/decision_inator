import 'dart:async';
import 'dart:math';

import 'package:decision_inator/components/result_banner_content.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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

  late final List<List<DecisionatorOption>> _modes;
  late final Random randomNumberGenerator;
  late final Frame frame;
  late final CollisionLine collisionLine;
  late final ResultBanner resultBanner;
  ResultBannerContent? resultBannerContent;
  late final BlackOverlay blackOverlay;

  @override
  FutureOr<void> onLoad() async {
    final screenRect = Rect.fromLTWH(0, 0, size.x, size.y);

    machineState = MachineState.attract;
    spinVelocity = Configuration.attractVelocity;
    randomNumberGenerator = Random();
    activeModeIndex = 0;
    frame = Frame();
    collisionLine = CollisionLine();
    resultBanner = ResultBanner();
    blackOverlay = BlackOverlay(screenRect);

    await FlameAudio.audioCache.load(Assets.click);
    await FlameAudio.audioCache.load(Assets.fanfare);

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

    _modes = [
      dinnerMode,
      choreMode,
      dateMode,
      streamingMode,
    ];

    addAll([
      ..._modes[activeModeIndex!],
      frame,
      collisionLine,
    ]);
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
    }

    if (newSpinVelocity < Configuration.minimumSpeedToBeConsideredSpinning) {
      if (!spinComplete) {
        machineState = MachineState.result;
        newSpinVelocity = Configuration.spinResultSpeed;
        FlameAudio.play(Assets.fanfare);
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

    if (newSpinVelocity != spinVelocity) {
      spinVelocity = newSpinVelocity;
    }
  }

  @override
  void onTap() {
    super.onTap();
    if (machineState != MachineState.spin &&
        machineState != MachineState.result) {
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

    final isM = keysPressed.contains(LogicalKeyboardKey.keyM);

    if (isSpace && isKeyDown) {
      if (machineState != MachineState.spin &&
          machineState != MachineState.result) {
        _startSpin();
      }
      return KeyEventResult.handled;
    }

    if (isM && isKeyDown) {
      if (machineState == MachineState.attract) {
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

        addAll([
          ..._modes[activeModeIndex!],
          frame,
          collisionLine,
        ]);

        return KeyEventResult.handled;
      }
    }

    return KeyEventResult.ignored;
  }

  void _startSpin() {
    spinVelocity =
        Configuration.spinBaseSpeed + randomNumberGenerator.nextInt(100) + 1;
    machineState = MachineState.spin;
  }

  void playClick() {
    FlameAudio.play(Assets.click);
  }
}
