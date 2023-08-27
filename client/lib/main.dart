import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_state.dart';
import 'keyboard/keyboard.dart';
import 'scrabble_scorer.dart';
import 'writing_zone.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentGameState>(
          create: (context) => CurrentGameState(),
        ),
        ChangeNotifierProvider<PlayedWordState>(
          create: (context) => PlayedWordState(),
        ),
        ChangeNotifierProvider<KeyboardWidgetState>(
          create: (context) => KeyboardWidgetState(),
        ),
      ],
      child: const ScrabbleScorer(),
    ),
  );
}
