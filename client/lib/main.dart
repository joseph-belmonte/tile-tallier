import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'current_game_state.dart';
import 'keyboard.dart';
import 'scrabble_scorer.dart';
import 'writing_zone.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentGameState>(
          create: (context) => CurrentGameState(),
        ),
        ChangeNotifierProvider<CurrentPlayState>(
          create: (context) => CurrentPlayState(),
        ),
        ChangeNotifierProvider<KeyboardWidgetState>(
          create: (context) => KeyboardWidgetState(),
        ),
        ChangeNotifierProvider<AppState>(
          create: (context) => AppState(),
        ),
      ],
      child: ScrabbleScorer(),
    ),
  );
}
