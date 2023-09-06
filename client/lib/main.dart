import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/routes/home_page.dart';

import 'active_game.dart';
import 'scrabble_scorer.dart';
import 'writing_zone.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ActiveGame>(
          create: (context) => ActiveGame(),
        ),
        ChangeNotifierProvider<CurrentPlayState>(
          create: (context) => CurrentPlayState(),
        ),
        ChangeNotifierProvider<AppState>(
          create: (context) => AppState(),
        ),
      ],
      child: MaterialApp(
        home: const HomePage(),
      ),
    ),
  );
}
