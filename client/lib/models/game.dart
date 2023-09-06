import 'package:flutter/material.dart';

/// Accepts a list of players and creates a new game state.
class Game {
  Game({required this.players});

  final List<Player> players;
  int _currentPlayerIndex = 0;

  Player get activePlayer => players[_currentPlayerIndex];
  

  int get _previousPlayerIndex {
    if (_currentPlayerIndex == 0) return players.length - 1;
    return _currentPlayerIndex - 1;
  }

  Player get currentPlayer => players[_currentPlayerIndex];
  Player get previousPlayer => players[_previousPlayerIndex];

  Play get currentPlay {
    // current player should have one more play than the previous player
    if (currentPlayer.plays.length == previousPlayer.plays.length) {
      currentPlayer.startTurn();
    }
    return currentPlayer.plays.last;
  }

  /// Returns all the plays in the game in reverse chronological order.
  List<Play> get plays {
    int playerIndex = _previousPlayerIndex;
    int playIndex = players[playerIndex].plays.length - 1;
    List<Play> playList = [];

    while (playIndex >= 0) {
      playList.add(players[playerIndex].plays[playIndex]);
      playIndex--;
      if (playerIndex < 0) playerIndex = players.length - 1;
      if (playerIndex == _previousPlayerIndex) playIndex--;
    }
    return playList;
  }

  /// Changes the active player to the next player in the list of players
  /// and adds a new play to the active player
  void endTurn() {
    _currentPlayerIndex = (_currentPlayerIndex + 1) % players.length;
  }

  Player getWinner() {
    Player winner = players[0];
    for (var player in players) {
      if (player.score > winner.score) {
        winner = player;
      }
    }
    return winner;
  }

  List<Player> getSortedPlayers() {
    var sortedPlayers = players;
    sortedPlayers.sort((a, b) => b.score.compareTo(a.score));
    return sortedPlayers;
  }
}

/// Accepts a name (String) and creates a new player with the given name and
/// an empty list of plays.
class Player {
  Player({required this.name});

  final String name;
  List<Play> plays = [];

  /// Returns the longest word played by the player.
  String get longestWord => plays
      .map((play) => play.playedWords.map((word) => word.word))
      .reduce((a, b) => a.length > b.length ? a : b)
      .toString();

  /// Returns the highest scoring word played by the player.
  PlayedWord get highestScoringWord => plays
      .map(
        (play) =>
            // if play has no playedWords, consider it a 0 score
            play.playedWords.isEmpty
                ? PlayedWord()
                : play.playedWords.reduce((a, b) => a.score > b.score ? a : b),
      )
      .reduce((a, b) => a.score > b.score ? a : b);

  /// Returns the highest scoring turn played by the player.
  Play get highestScoringTurn =>
      plays.reduce((a, b) => a.score > b.score ? a : b);

  /// Returns the shortest word played by the player.
  String get shortestWord => plays
      .map((play) => play.playedWords.map((word) => word.word))
      .reduce((a, b) => a.length < b.length ? a : b)
      .toString();

  /// Returns the score for the player by summing the scores for each play.
  int get score {
    var score = 0;
    for (var play in plays) {
      score += play.score;
    }
    return score;
  }

  /// Adds a new play to the list of plays.
  void startTurn() {
    plays.add(Play([], this));
  }
}

/// Accepts a list of PlayedWord objects and a boolean value for whether or not
/// the play is a bingo.
/// A word is a list of PlayedLetter objects.
/// A bingo is when a player uses all 7 letters in their rack in a single turn.
class Play {
  Play(this.playedWords, this.player, {this.isBingo = false});

  List<PlayedWord> playedWords = [];
  Player player;
  bool isBingo = false;

  /// Returns the score for the play by summing the scores for each PlayedWord
  /// object.
  /// If the play is a bingo, 50 points are added to the score.
  int get score {
    var score = 0;
    for (var word in playedWords) {
      score += word.score;
    }
    if (isBingo) score += 50;
    return score;
  }
}

enum ScrabbleEdition {
  classic,
  twentyFifthAnniversary,
}

enum ScoreMultiplier {
  singleWord(1, '1X'),
  singleLetter(1, '1X'),
  doubleLetter(2, '2X'),
  doubleWord(2, '2X'),
  tripleLetter(3, '3X'),
  tripleWord(3, '3X');

  const ScoreMultiplier(this.value, this.label);

  final int value;
  final String label;
  static const Map<ScrabbleEdition, Map<ScoreMultiplier, Color>> colors = {
    ScrabbleEdition.classic: {
      ScoreMultiplier.singleLetter: Colors.amber,
      ScoreMultiplier.singleWord: Color.fromRGBO(255, 255, 255, 1),
      ScoreMultiplier.doubleWord: Color.fromARGB(255, 243, 125, 125),
      ScoreMultiplier.tripleWord: Color.fromARGB(255, 255, 0, 0),
      ScoreMultiplier.doubleLetter: Color.fromARGB(255, 123, 213, 241),
      ScoreMultiplier.tripleLetter: Color.fromARGB(255, 50, 56, 240),
    },
    ScrabbleEdition.twentyFifthAnniversary: {
      ScoreMultiplier.singleLetter: Colors.amber,
      ScoreMultiplier.singleWord: Color.fromRGBO(255, 255, 255, 1),
      ScoreMultiplier.doubleWord: Color.fromARGB(255, 114, 11, 0),
      ScoreMultiplier.tripleWord: Color.fromARGB(255, 67, 13, 0),
      ScoreMultiplier.doubleLetter: Color.fromARGB(255, 184, 240, 0),
      ScoreMultiplier.tripleLetter: Color.fromARGB(255, 5, 158, 0),
    },
  };

  Color editionColor(ScrabbleEdition edition) => colors[edition]![this]!;
}

/// Accepts a list of PlayedLetter objects and an enum value for the word
/// multiplier.
class PlayedWord {
  List<PlayedLetter> playedLetters = [];
  ScoreMultiplier wordMultiplier = ScoreMultiplier.singleWord;

  /// Returns the word as a string by converting each PlayedLetter object to its
  /// letter property and joining them together.
  String get word => playedLetters.map((e) => e.letter).join();

  /// Returns the score for the word by summing the scores for each PlayedLetter
  /// object.
  int get score {
    var score = 0;
    for (var letter in playedLetters) {
      score += letter.score;
    }
    return score * wordMultiplier.value;
  }

  void toggleWordMultiplier() {
    switch (wordMultiplier) {
      case ScoreMultiplier.singleWord:
        wordMultiplier = ScoreMultiplier.doubleWord;
      case ScoreMultiplier.doubleWord:
        wordMultiplier = ScoreMultiplier.tripleWord;
      case ScoreMultiplier.tripleWord:
        wordMultiplier = ScoreMultiplier.singleWord;
      default:
        throw Exception('Invalid word multiplier');
    }
  }
}

/// Accepts a letter (String) and an enum value for the letter multiplier.
class PlayedLetter {
  PlayedLetter(String letter) {
    this.letter = letter.toUpperCase();
  }

  late final String letter;
  ScoreMultiplier letterMultiplier = ScoreMultiplier.singleLetter;

  /// Returns the score for the letter.
  int get score => (letterScores[letter] ?? 0) * letterMultiplier.value;

  static const Map<String, int> letterScores = {
    'A': 1,
    'B': 3,
    'C': 3,
    'D': 2,
    'E': 1,
    'F': 4,
    'G': 2,
    'H': 4,
    'I': 1,
    'J': 8,
    'K': 5,
    'L': 1,
    'M': 3,
    'N': 1,
    'O': 1,
    'P': 3,
    'Q': 10,
    'R': 1,
    'S': 1,
    'T': 1,
    'U': 1,
    'V': 4,
    'W': 4,
    'X': 8,
    'Y': 4,
    'Z': 10,
    ' ': 0,
  };

  void toggleLetterMultiplier() {
    switch (letterMultiplier) {
      case ScoreMultiplier.singleLetter:
        letterMultiplier = ScoreMultiplier.doubleLetter;
      case ScoreMultiplier.doubleLetter:
        letterMultiplier = ScoreMultiplier.tripleLetter;
      case ScoreMultiplier.tripleLetter:
        letterMultiplier = ScoreMultiplier.singleLetter;
      default:
        throw Exception('Invalid letter multiplier');
    }
  }
}
