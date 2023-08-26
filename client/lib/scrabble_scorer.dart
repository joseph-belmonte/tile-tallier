import 'package:flutter/material.dart';

import 'models/game_state.dart';
import 'score_page.dart';

class GameStateNotifier extends ChangeNotifier {
  GameState gameState = GameState(
    players: [
      Player(name: 'JB'),
      Player(name: 'RW'),
      Player(name: 'JC'),
      Player(name: 'MJ'),
    ],
  );

  int activePlayerIndex = 0;

  /// Changes the active player to the next player in the list of players
  /// and adds a new play to the active player
  void endTurn() {
    var players = gameState.players;

    activePlayerIndex = (activePlayerIndex + 1) % players.length;
    // add a new play to the active player
    players[activePlayerIndex]
        .plays
        .add(Play(playedWords: List.empty(growable: true)));

    notifyListeners();
  }

  /// Accepts a word of type PlayedWord and adds it to the list of played words
  /// for the current Play
  void addWordToCurrentPlay(PlayedWord word) {
    final activePlayer = gameState.players[activePlayerIndex];
    final currentPlay = activePlayer.plays.last;

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
