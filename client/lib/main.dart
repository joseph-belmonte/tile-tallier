import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/keyboard/keyboard.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';
import 'package:scrabble_scorer/writing_zone.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GameStateNotifier>(
          create: (context) => GameStateNotifier(),
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
