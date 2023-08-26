import 'package:flutter/material.dart';

import 'models/game_state.dart';
import 'score_page.dart';

class GameStateNotifier extends ChangeNotifier {
  GameState gameState = GameState(
    players: [
      Player(name: 'JB'),
      Player(name: 'RW'),
      Player(name: 'JC'),
      Player(name: 'MAJ'),
    ],
  );

  int activePlayerIndex = 0;

  void endTurn() {
    // increment the active player index
    activePlayerIndex = (activePlayerIndex + 1) % gameState.players.length;
    // add a new play to the active player
    gameState.players[activePlayerIndex].plays
        .add(Play(playedWords: List.empty(growable: true)));
    notifyListeners();
  }

  void addWord(PlayedWord word) {
    if (gameState.players[activePlayerIndex].plays.isEmpty) {
      gameState.players[activePlayerIndex].plays
          .add(Play(playedWords: List.empty(growable: true)));
    }
    final currentPlay = gameState.players[activePlayerIndex].plays.last;
    currentPlay.playedWords.add(word);
    currentPlay.isBingo =
        currentPlay.playedWords.last.playedLetters.length == 7;
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
