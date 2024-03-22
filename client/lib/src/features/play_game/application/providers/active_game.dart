// This file should only contain methods that alter the state of the game
// ActiveGameNotifier (StateNotifier Class):
// The ActiveGameNotifier class should be responsible for interacting with the Game model and broadcasting updates to its state. It acts as a bridge between your UI and the game logic contained within the Game class. Methods in the notifier should:

// This includes methods for adding players, ending turns, adding words to the current play,
// and updating the current word. You should also move the methods for toggling the word multiplier and bingo status to the ActiveGameNotifier class.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import '../../../../../enums/score_multipliers.dart';
import '../../domain/models/game.dart';

import '../../domain/models/letter.dart';
import '../../domain/models/play.dart';
import '../../domain/models/player.dart';
import '../../domain/models/word.dart';

final _logger = Logger();

/// A [StateNotifier] that manages the state of the active game.
class ActiveGameNotifier extends StateNotifier<Game> {
  /// Creates a new [ActiveGameNotifier] with a new game
  ActiveGameNotifier(Game game) : super(game);

  /// Adds players to the game, based on a list of names
  void setPlayers(List<String> playerNames) {
    var players = playerNames.map((name) => Player(name: name, id: Uuid().v4())).toList();
    state = state.copyWith(players: players);
  }

  /// * Adds the current play to the active player's list of plays.
  /// * Advances the game to the next player's turn
  void endTurn() {
    var currentPlayer = state.players[state.currentPlayerIndex];

    var updatedPlayer = currentPlayer.copyWith(
      plays: [...currentPlayer.plays, state.currentPlay],
    );

    var updatedPlayers = List<Player>.from(state.players);

    updatedPlayers[state.currentPlayerIndex] = updatedPlayer;

    var nextIndex = (state.currentPlayerIndex + 1) % state.players.length;

    state = state.copyWith(
      currentPlay: Play(),
      currentWord: Word(),
      currentPlayerIndex: nextIndex,
      players: updatedPlayers,
    );
  }

  /// * Sets the current player to the previous player
  void undoTurn() {
    var previousIndex = (state.currentPlayerIndex - 1) % state.players.length;
    state = state.copyWith(currentPlayerIndex: previousIndex);
  }

  /// Converts the input string to a [Word] and adds it to the current play
  void addWordToCurrentPlay(String input) {
    _logger.i('Current word being added: ${state.currentWord.word}');
    var newWord = Word();
    for (var char in input.split('')) {
      var letter = Letter(letter: char);
      newWord = newWord.copyWith(playedLetters: [...newWord.playedLetters, letter]);
    }

    var updatedPlay = state.currentPlay.copyWith(
      playedWords: [...state.currentPlay.playedWords, newWord],
    );

    state = state.copyWith(currentPlay: updatedPlay, currentWord: Word());
  }

  /// Updates the current word with the input string
  void updateCurrentWord(String input) {
    var newWord = Word();
    for (var char in input.split('')) {
      var letter = Letter(letter: char);
      newWord = newWord.copyWith(playedLetters: [...newWord.playedLetters, letter]);
    }
    state = state.copyWith(currentWord: newWord);
  }

  /// Toggles the current word multiplier
  void toggleCurrentWordMultiplier() {
    final index = WordScoreMultiplier.values.indexOf(state.currentWord.wordMultiplier);
    final nextIndex = (index + 1) % WordScoreMultiplier.values.length;
    final updatedWord = Word(
      playedLetters: state.currentWord.playedLetters,
      wordMultiplier: WordScoreMultiplier.values[nextIndex],
    );
    state = state.copyWith(currentWord: updatedWord);
  }

  /// Toggles the current play's bingo status
  void toggleBingo() {
    var updatedPlay = state.currentPlay.copyWith(isBingo: !state.currentPlay.isBingo);
    state = state.copyWith(currentPlay: updatedPlay);
  }
}

/// A provider that exposes the [ActiveGameNotifier] to the UI
final activeGameProvider = StateNotifierProvider<ActiveGameNotifier, Game>(
  (ref) => ActiveGameNotifier(
    Game(
      id: Uuid().v4(),
    ),
  ),
);


  /// Toggles the letter multiplier between single, double, and triple letter.
  // void toggleLetterMultiplier() {
  //   switch (letterMultiplier) {
  //     case LetterScoreMultiplier.singleLetter:
  //       letterMultiplier = LetterScoreMultiplier.doubleLetter;
  //       break;
  //     case LetterScoreMultiplier.doubleLetter:
  //       letterMultiplier = LetterScoreMultiplier.tripleLetter;
  //       break;
  //     case LetterScoreMultiplier.tripleLetter:
  //       letterMultiplier = LetterScoreMultiplier.singleLetter;
  //       break;
  //     default:
  //       throw Exception('Invalid letter multiplier');
  //   }
  // }
  
