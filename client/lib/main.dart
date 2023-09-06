import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'current_game_state.dart';
import 'scrabble_scorer.dart';
import 'writing_zone.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentGameState>(create: (_) => CurrentGameState()),
        ChangeNotifierProvider<CurrentPlayState>(create: (_) => CurrentPlayState()),
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
      ],
      child: ScrabbleScorer(),
    ),
  );
}
