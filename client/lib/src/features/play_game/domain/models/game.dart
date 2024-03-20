// Game Model (Game Class):
// The Game class should encapsulate the core domain logic related to a game entity. It should define the properties of a game and methods that operate on those properties. In essence, it should:

// Hold the game's state, like the list of players, current player, plays, etc.
// Provide methods that change its state in a way that is consistent with the rules of your game domain.

import 'package:uuid/uuid.dart';

import '../../../../../enums/score_multipliers.dart';
import 'letter.dart';
import 'play.dart';
import 'player.dart';
import 'word.dart';

final _uuid = Uuid();

/// Accepts a list of players and creates a new game state.
class Game {
  /// The unique identifier for the game.
  final String id = _uuid.v4();

  /// The game's players.
  final List<Player> _players = [];

  /// The index of the current player.
  int _currentPlayerIndex = 0;

  /// The current play.
  Play currentPlay = Play();

  /// The current word being played.
  Word currentWord = Word();

  /// Creates a new Game instance.
  Game();

  /// Returns the game's players in the order they were added.
  List<Player> get players => _players;

  /// Returns the game's players sorted by score.
  List<Player> get sortedPlayers {
    var sortedPlayers = _players.toList();
    sortedPlayers.sort((a, b) => b.score.compareTo(a.score));
    return sortedPlayers;
  }

  /// Returns the current player.
  Player get currentPlayer => _players[_currentPlayerIndex];

  /// Returns the game's current leader.
  Player get winner {
    var winner = _players[0];
    for (var player in _players) {
      if (player.score > winner.score) winner = player;
    }
    return winner;
  }

  /// Returns the list of plays in the game.
  List<Play> get plays => _players.expand((player) => player.plays).toList();

  /// Returns the highest scoring turn played in the game.
  Play? get highestScoringPlay {
    if (plays.isEmpty) return null;

    // Initialize variables to keep track of the highest-scoring turn and its score
    var highestScoring = plays.first;
    var maxScore = highestScoring.score;

    // Iterate through plays to find the highest-scoring turn
    for (var play in plays) {
      if (play.score > maxScore) {
        maxScore = play.score;
        highestScoring = play;
      }
    }

    return highestScoring;
  }

  /// Returns the highest scoring word played in the game.
  Word get highestScoringWord {
    if (plays.isEmpty) return Word();

    var highestScoring = Word();
    var maxScore = 0;

    for (var play in plays) {
      for (var word in play.playedWords) {
        if (word.score > maxScore) {
          maxScore = word.score;
          highestScoring = word;
        }
      }
    }
    return highestScoring;
  }

  /// Returns the longest word played in the game.
  String get longestWord {
    if (plays.isEmpty) return '';

    var longest = plays.first.playedWords.first.word;
    var maxLength = longest.length;

    for (var play in plays) {
      if (play.playedWords.isEmpty) continue;
      for (var word in play.playedWords) {
        if (word.word.length > maxLength) {
          maxLength = word.word.length;
          longest = word.word;
        }
      }
    }
    return longest;
  }

  /// Returns the shortest word played in the game.
  String get shortestWord {
    if (plays.isEmpty) return '';

    var shortest = plays.first.playedWords.first.word;
    var minLength = shortest.length;

    for (var play in plays) {
      for (var word in play.playedWords) {
        if (word.word.length < minLength) {
          minLength = word.word.length;
          shortest = word.word;
        }
      }
    }
    return shortest;
  }

  /// Adds players to the game.
  void addPlayers(List<String> playerNames) {
    _players.addAll(playerNames.map((name) => Player(name: name)));
  }

  /// Clears the current play, and advances the game to the next player's turn.
  void _nextTurn() {
    // Add the current play to the current player's list of plays
    currentPlayer.plays = [...currentPlayer.plays, currentPlay];

    // Reset the current play and word.
    currentPlay = Play();
    currentWord = Word();

    // Move to the next players
    _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
  }

  /// Ends the current turn and progresses to the next player.
  void endTurn() => _nextTurn();

  /// Adds a word to the current play.
  void addWordToCurrentPlay(String input) {
    var word = Word();
    for (var char in input.split('')) {
      var letter = Letter(char);
      word.playedLetters = [...word.playedLetters, letter];
    }
    currentPlay.playedWords = [...currentPlay.playedWords, word];
  }

  /// Updates the current word.
  void updateCurrentWord(String input) {
    var newWord = Word();
    for (var char in input.split('')) {
      var letter = Letter(char);
      newWord.playedLetters = [...newWord.playedLetters, letter];
    }
    currentWord = newWord;
  }

  /// Toggles the current word multiplier
  void toggleCurrentWordMultiplier() {
    final index = WordScoreMultiplier.values.indexOf(currentWord.wordMultiplier);
    final nextIndex = (index + 1) % WordScoreMultiplier.values.length;
    final newWord = Word(
      playedLetters: currentWord.playedLetters,
      wordMultiplier: WordScoreMultiplier.values[nextIndex],
    );
    currentWord = newWord;
  }

  /// Toggles whether the current play is a bingo.
  void toggleBingo() {
    currentPlay.isBingo = !currentPlay.isBingo;
  }
}
