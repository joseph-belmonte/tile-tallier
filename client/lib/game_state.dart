import 'package:flutter/material.dart';

import 'models/game_state.dart';

class CurrentGameState extends ChangeNotifier {
  GameState gameState = GameState(
    players: [
      Player(name: 'JB'),
      Player(name: 'RW'),
      Player(name: 'JC'),
      Player(name: 'MJ'),
    ],
  );
  List<Play> plays = [];

  /// Changes the active player to the next player in the list of players
  /// and adds a new play to the active player
  void endTurn() {
    // save the current play in the list of plays
    gameState.endTurn();
    notifyListeners();
  }

  /// Accepts a word of type PlayedWord and adds it to the list of played words
  /// for the current Play
  void addWordToCurrentPlay(PlayedWord word) {
    if (gameState.activePlayer.plays.isEmpty) {
      gameState.activePlayer.startTurn();
    }
    final currentPlay = gameState.activePlayer.plays.last;

    currentPlay.playedWords.add(word);
    currentPlay.isBingo =
        currentPlay.playedWords.last.playedLetters.length == 7;
    notifyListeners();
  }
}
