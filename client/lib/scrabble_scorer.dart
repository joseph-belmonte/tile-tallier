import 'package:flutter/material.dart';

import 'score_page.dart';

class ScrabbleScorer extends StatelessWidget {
  const ScrabbleScorer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrabble Score Keeper',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 189, 25, 25)),
        useMaterial3: true,
      ),
      home: const ScorePage(title: 'Scrabble Score Keeper'),
    );
  }
}
