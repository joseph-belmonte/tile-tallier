// This file should only contain methods that alter the state of the game
// ActiveGameNotifier (StateNotifier Class):
// The ActiveGameNotifier class should be responsible for interacting with the Game model and broadcasting updates to its state. It acts as a bridge between your UI and the game logic contained within the Game class. Methods in the notifier should:

// This includes methods for adding players, ending turns, adding words to the current play,
// and updating the current word. You should also move the methods for toggling the word multiplier and bingo status to the ActiveGameNotifier class.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../enums/score_multiplier.dart';
import '../../../../enums/word_theme.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/logger.dart';
import '../../../core/domain/models/game.dart';
import '../../../core/domain/models/game_player.dart';
import '../../../core/domain/models/letter.dart';
import '../../../core/domain/models/play.dart';
import '../../../core/domain/models/word.dart';

import '../../../edit_settings/presentation/controllers/settings_controller.dart';
import '../../../shared/data/helpers/players_table_helper.dart';

import 'word_db_repository.dart';

/// A [StateNotifier] that manages the state of the active game.
class ActiveGameNotifier extends StateNotifier<Game> {
  /// Creates a new [ActiveGameNotifier] with a new game
  ActiveGameNotifier(this.ref, super.game);

  /// A reference to the global provider container
  final Ref ref;

  final _playerTableHelper = PlayerTableHelper();

  /// Creates a new game instance with:
  /// * A new UUID
  /// * A new play with the current timestamp
  /// * The list of passed in players
  Future<void> startGame(List<String> playerNames) async {
    final newGameId = Uuid().v4();

    final newPlayers = await Future.wait(
      playerNames.map(
        (name) async {
          // ignore: unused_local_variable
          var isExistingPlayer = false;
          var playerId = '';
          try {
            final player = await _playerTableHelper.findPlayer(name: name);
            if (player != null) {
              isExistingPlayer = true;
              playerId = player.id;
            } else {
              isExistingPlayer = false;
              playerId = Uuid().v4();
            }
          } catch (e) {
            isExistingPlayer = false;
            logger.e('Error fetching player: $e');
            playerId = Uuid().v4();
          }
          return GamePlayer(
            name: name,
            id: Uuid().v4(),
            gameId: newGameId,
            playerId: playerId,
            plays: [],
            endRack: '',
          );
        },
      ).toList(),
    );

    final newPlay = Play(
      gameId: newGameId,
      id: Uuid().v4(),
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      id: newGameId,
      players: newPlayers,
      currentPlay: newPlay,
      currentPlayerIndex: 0,
    );
  }

  /// Updates the players in the game.
  void updatePlayers(List<GamePlayer> players) {
    state = state.copyWith(players: players);
  }

  /// * Adds the current play to the active player's list of plays.
  /// * Advances the game to the next player's turn
  void endTurn() {
    final currentPlayer = state.players[state.currentPlayerIndex];

    // Ensure currentPlay has all necessary data before copying.
    final completedPlay =
        state.currentPlay!.copyWith(playerId: currentPlayer.id);

    // Update the current player with the new play.
    final updatedPlayer = currentPlayer.copyWith(
      plays: [...currentPlayer.plays, completedPlay],
    );

    // Prepare for next player's turn.
    final nextIndex = (state.currentPlayerIndex + 1) % state.players.length;
    final nextPlayerId = state.players[nextIndex].id;

    final newPlay = Play(
      gameId: state.id,
      id: Uuid().v4(),
      playerId: nextPlayerId,
      timestamp: DateTime.now(),
    );
    final newWord = Word(
      id: Uuid().v4(),
    );
    final newPlayers = List<GamePlayer>.from(state.players)
      ..[state.currentPlayerIndex] = updatedPlayer;

    // Update state with changes for the next turn.
    state = state.copyWith(
      // Assuming the Play constructor sets up a new play correctly for the next player.
      currentPlay: newPlay,
      currentWord: newWord,
      currentPlayerIndex: nextIndex,
      players: newPlayers,
    );
  }

  /// Reverts the last turn and make the previous player the current player
  void undoTurn() {
    // Handle the case where the current player is the first player.
    if (state.plays.isEmpty) {
      return;
    } else {
      // First, clear any current words before undoing the turn.
      if (state.currentPlay!.playedWords.isNotEmpty) {
        state = state.copyWith(
          currentPlay: state.currentPlay!.copyWith(
            playedWords: [],
          ),
        );
        return;
      } else {
        // Make the previous player the current player.
        final newPlayerIndex =
            (state.currentPlayerIndex - 1) % state.players.length;
        final newPlayer = state.players[newPlayerIndex];

        // Remove the last play from this player.
        final updatedPlayer = newPlayer.copyWith(
          plays: newPlayer.plays.sublist(0, newPlayer.plays.length - 1),
        );

        // Update the state with the changes:
        state = state.copyWith(
          players: List<GamePlayer>.from(state.players)
            ..[newPlayerIndex] = updatedPlayer,
          currentPlayerIndex: newPlayerIndex,
          currentPlay: Play(
            id: Uuid().v4(),
            gameId: state.id,
            playerId: newPlayer.id,
            timestamp: DateTime.now(),
          ),
          currentWord: Word(
            id: Uuid().v4(),
          ),
        );
      }
    }
  }

  /// Converts the input string to a [Word] and adds it to the current play
  void addWordToCurrentPlay(String input) {
    var newWord = Word(
      id: Uuid().v4(),
    );
    for (var char in input.split('')) {
      final letter = Letter(
        id: Uuid().v4(),
        letter: char,
        scoreMultiplier: state.currentWord!
            .playedLetters[newWord.playedLetters.length].scoreMultiplier,
      );
      newWord =
          newWord.copyWith(playedLetters: [...newWord.playedLetters, letter]);
    }

    final updatedPlay = state.currentPlay!.copyWith(
      playedWords: [...state.currentPlay!.playedWords, newWord],
    );

    state = state.copyWith(
      currentPlay: updatedPlay,
      currentWord: Word(
        id: Uuid().v4(),
      ),
    );
  }

  /// Updates the current word with the input string
  void updateCurrentWord(String input) {
    var newWord = Word(
      id: Uuid().v4(),
    );
    for (var char in input.split('')) {
      final letter = Letter(
        id: Uuid().v4(),
        letter: char,
      );
      newWord =
          newWord.copyWith(playedLetters: [...newWord.playedLetters, letter]);
    }
    state = state.copyWith(currentWord: newWord);
  }

  /// Given a word and index of a letter, toggles the letter's multiplier
  void toggleScoreMultiplier(Word word, int index) {
    final letter = word.playedLetters[index];
    final currentMultiplier = letter.scoreMultiplier;
    final newMultiplier = ScoreMultiplier
        .values[(currentMultiplier.index + 1) % ScoreMultiplier.values.length];
    final updatedLetter = letter.copyWith(
      scoreMultiplier: newMultiplier,
    );

    final updatedWord = word.copyWith(
      playedLetters: List<Letter>.from(word.playedLetters)
        ..[index] = updatedLetter,
    );

    state = state.copyWith(currentWord: updatedWord);
  }

  /// Toggles the current play's bingo status
  void toggleBingo() {
    final updatedPlay =
        state.currentPlay!.copyWith(isBingo: !state.currentPlay!.isBingo);
    state = state.copyWith(currentPlay: updatedPlay);
  }

  /// Whether a word or any wildcard variation of the word exists in the database
  Future<bool> isValidWord(String word) async {
    // If greater than 2 spaces, return false
    if (RegExp(' ').allMatches(word).length > 2) return false;
    final possibleWords = generateWildcardWords(word.toLowerCase());

    final activeTheme = WordTheme.values.firstWhere(
      (theme) => theme.name == ref.watch(Settings.wordThemeProvider),
    );

    // Check if the word exists in the database, using the repository provider
    final wordDbRepository = ref.read(wordDatabaseProvider);
    for (final possibleWord in possibleWords) {
      final wordExists =
          await wordDbRepository.isWordValid(possibleWord, activeTheme);
      if (wordExists) {
        return true;
      }
    }

    return false;
  }

  /// Ends the game by setting the current play and word to null
  void endGame() {
    state = state.copyWith(
      currentPlay: null,
      currentWord: null,
    );
  }
}

/// A provider that exposes the [ActiveGameNotifier] to the UI
final activeGameProvider = StateNotifierProvider<ActiveGameNotifier, Game>(
  (ref) => ActiveGameNotifier(
    ref,
    Game(
      id: Uuid().v4(),
      currentPlay: Play.createNew(gameId: Uuid().v4()),
      currentWord: Word.createNew(),
    ),
  ),
);
