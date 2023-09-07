import 'package:flutter/material.dart';

import 'models/game.dart';

class ActiveGame extends ChangeNotifier {
  Game activeGame = Game(
    players: [
      Player(name: 'JB'),
      Player(name: 'RW'),
      Player(name: 'JC'),
      Player(name: 'MJ'),
    ],
  );
  List<Play> plays = [];

  /// Gets the list of players from the active game
  List<Player> get players => activeGame.getPlayers();

  /// Changes the active player to the next player in the list of players
  /// and adds a new play to the active player
  void endTurn() {
    // save the current play in the list of plays
    activeGame.endTurn();
    notifyListeners();
  }

  /// Accepts a word of type PlayedWord and adds it to the list of played words
  /// for the current Play
  void addWordToCurrentPlay(PlayedWord word) {
    activeGame.currentPlay.playedWords.add(word);
    notifyListeners();
  }

  /// Toggles the isBingo property for the current word
  void toggleBingo() {
    activeGame.currentPlay.isBingo = !activeGame.currentPlay.isBingo;
    notifyListeners();
  }
}
