import 'package:decision_inator/app/decisioninator.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();

  final app = Decisioninator();
  runApp(
    GameWidget(
      game: app,
    ),
  );
}
