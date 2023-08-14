import 'package:flutter/material.dart';

import 'models/game_state.dart';
import 'score_page.dart';

class GameStateNotifier extends ChangeNotifier {
  GameState gameState = GameState(players: [
    Player(name: 'Joe'),
    Player(name: 'J.I.'),
  ]);

  int activePlayerIndex = 0;

  void nextPlayer() {
    activePlayerIndex = (activePlayerIndex + 1) % gameState.players.length;
  }

  final List<List<String>> playedWords = [];

  void addWord(String word) {
    playedWords.add([word, gameState.players[activePlayerIndex].name]);
    nextPlayer();
    notifyListeners();
  }
}

class ScrabbleScorer extends StatelessWidget {
  const ScrabbleScorer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ScorePage(title: 'Scrabble Scope Keeper'),
    );
  }
}
