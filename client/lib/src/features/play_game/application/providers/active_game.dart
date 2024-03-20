// This file should only contain methods that alter the state of the game
// ActiveGameNotifier (StateNotifier Class):
// The ActiveGameNotifier class should be responsible for interacting with the Game model and broadcasting updates to its state. It acts as a bridge between your UI and the game logic contained within the Game class. Methods in the notifier should:

// Invoke methods on the Game object to change its state.
// Ensure that any state changes are broadcast to the UI (which StateNotifier does by setting the state property).

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/game.dart';

import '../../domain/models/word.dart';

/// A [StateNotifier] that manages the state of the active game.
class ActiveGameNotifier extends StateNotifier<Game> {
  /// Creates a new [ActiveGameNotifier] with a new game
  ActiveGameNotifier(Game game) : super(game);

  /// Adds players to the game, based on a list of names
  void setPlayers(List<String> players) {
    state.addPlayers(players);
    state = state;
  }

  /// Ends the current turn and progresses to the next player
  void endTurn() {
    state.endTurn();
    state = state;
  }

  /// Accepts a [String], converts it to a [Word], and adds it to the current play
  void addWordToCurrentPlay(String word) {
    state.addWordToCurrentPlay(word);
    state = state;
  }

  /// Updates the current word
  void updateCurrentWord(String word) {
    state.updateCurrentWord(word);
    state = state;
  }

  /// Toggles the current word's multiplier
  void toggleWordMultiplier() {
    state.toggleCurrentWordMultiplier();
    state = state;
  }

  /// Toggles the current play's bingo status
  void toggleBingo() {
    state.toggleBingo();
    state = state;
  }
}

/// A provider that exposes the [ActiveGameNotifier] to the UI
final activeGameProvider = StateNotifierProvider<ActiveGameNotifier, Game>(
  (ref) => ActiveGameNotifier(Game()),
);
