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

  int activePlayerIndex = 0;

  /// Changes the active player to the next player in the list of players
  /// and adds a new play to the active player
  void endTurn() {
    var players = gameState.players;

    // save the current play in the list of plays
    plays.add(players[activePlayerIndex].plays.last);

    activePlayerIndex = (activePlayerIndex + 1) % players.length;
    // add a new play to the active player
    players[activePlayerIndex].startTurn();

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
