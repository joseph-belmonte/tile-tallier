// This file should only contain methods that alter the state of the game
// ActiveGameNotifier (StateNotifier Class):
// The ActiveGameNotifier class should be responsible for interacting with the Game model and broadcasting updates to its state. It acts as a bridge between your UI and the game logic contained within the Game class. Methods in the notifier should:

// This includes methods for adding players, ending turns, adding words to the current play,
// and updating the current word. You should also move the methods for toggling the word multiplier and bingo status to the ActiveGameNotifier class.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:uuid/uuid.dart';
import '../../../../../enums/score_multipliers.dart';
import '../../domain/models/game.dart';

import '../../domain/models/letter.dart';
import '../../domain/models/play.dart';
import '../../domain/models/player.dart';
import '../../domain/models/word.dart';

/// A [StateNotifier] that manages the state of the active game.
class ActiveGameNotifier extends StateNotifier<Game> {
  /// Creates a new [ActiveGameNotifier] with a new game
  ActiveGameNotifier(Game game) : super(game);

  /// Adds players to the game, based on a list of names
  void setPlayers(List<String> playerNames) {
    final players = playerNames.map((name) => Player(name: name, id: Uuid().v4())).toList();
    state = state.copyWith(players: players);
  }

  /// * Adds the current play to the active player's list of plays.
  /// * Advances the game to the next player's turn
  void endTurn() {
    final currentPlayer = state.players[state.currentPlayerIndex];

    final updatedPlayer = currentPlayer.copyWith(
      plays: [...currentPlayer.plays, state.currentPlay],
    );

    final updatedPlayers = List<Player>.from(state.players);

    updatedPlayers[state.currentPlayerIndex] = updatedPlayer;

    final nextIndex = (state.currentPlayerIndex + 1) % state.players.length;

    state = state.copyWith(
      currentPlay: Play(),
      currentWord: Word(),
      currentPlayerIndex: nextIndex,
      players: updatedPlayers,
    );
  }

  /// * Sets the current player to the previous player
  void undoTurn() {
    final previousIndex = (state.currentPlayerIndex - 1) % state.players.length;
    state = state.copyWith(currentPlayerIndex: previousIndex);
  }

  /// Converts the input string to a [Word] and adds it to the current play
  void addWordToCurrentPlay(String input) {
    var newWord = Word();
    for (var char in input.split('')) {
      final letter = Letter(
        letter: char,
        scoreMultiplier:
            state.currentWord.playedLetters[newWord.playedLetters.length].scoreMultiplier,
      );
      newWord = newWord.copyWith(playedLetters: [...newWord.playedLetters, letter]);
    }

    final updatedPlay = state.currentPlay.copyWith(
      playedWords: [...state.currentPlay.playedWords, newWord],
    );

    state = state.copyWith(currentPlay: updatedPlay, currentWord: Word());
  }

  /// Updates the current word with the input string
  void updateCurrentWord(String input) {
    var newWord = Word();
    for (var char in input.split('')) {
      final letter = Letter(letter: char);
      newWord = newWord.copyWith(playedLetters: [...newWord.playedLetters, letter]);
    }
    state = state.copyWith(currentWord: newWord);
  }

  /// Given a word and index of a letter, toggles the letter's multiplier
  void toggleScoreMultiplier(Word word, int index) {
    final letter = word.playedLetters[index];
    final currentMultiplier = letter.scoreMultiplier;
    final newMultiplier =
        ScoreMultiplier.values[(currentMultiplier.index + 1) % ScoreMultiplier.values.length];
    final updatedLetter = letter.copyWith(
      scoreMultiplier: newMultiplier,
    );

    final updatedWord = word.copyWith(
      playedLetters: List<Letter>.from(word.playedLetters)..[index] = updatedLetter,
    );

    state = state.copyWith(currentWord: updatedWord);
  }

  /// Toggles the current play's bingo status
  void toggleBingo() {
    final updatedPlay = state.currentPlay.copyWith(isBingo: !state.currentPlay.isBingo);
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
  // void togglescoreMultiplier() {
  //   switch (scoreMultiplier) {
  //     case LetterScoreMultiplier.singleLetter:
  //       scoreMultiplier = LetterScoreMultiplier.doubleLetter;
  //       break;
  //     case LetterScoreMultiplier.doubleLetter:
  //       scoreMultiplier = LetterScoreMultiplier.tripleLetter;
  //       break;
  //     case LetterScoreMultiplier.tripleLetter:
  //       scoreMultiplier = LetterScoreMultiplier.singleLetter;
  //       break;
  //     default:
  //       throw Exception('Invalid letter multiplier');
  //   }
  // }
  
