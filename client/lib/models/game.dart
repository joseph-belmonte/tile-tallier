import 'package:flutter/material.dart';

class CyclicList<T> {
  late List<T> _list;
  late int _i;

  CyclicList(List<T> list, {int startIndex = 0}) {
    _list = List.from(list);
    _i = startIndex;
  }

  T operator [](int index) => _list[index % _list.length];
  List<T> get list => _list.toList();
  int get length => _list.length;
  int get currentIndex => _i;
  T get current => _list[_i];
  T get next => this[_i + 1];
  T get previous => this[_i - 1];

  int _indexBefore(int index) => (index - 1) % _list.length;
  int _indexAfter(int index) => (index + 1) % _list.length;

  void nextItem() => _i = _indexAfter(_i);
  void previousItem() => _i = _indexBefore(_i);
}

/// Accepts a list of players and creates a new game state.
class Game extends CyclicList<Player> {
  Game({required List<Player> players}) : super(players) {
    current.startTurn();
  }

  /// Returns the current player.
  Player get currentPlayer => current;

  /// Returns the current player's current play.
  Play get currentPlay => currentPlayer.plays.last;

  /// Returns all the plays in the game in reverse chronological order.
  List<Play> get plays {
    int playerIndex = _indexBefore(_i);
    int playIndex = previous.plays.length - 1;
    List<Play> playList = [];

    while (playIndex >= 0) {
      playList.add(_list[playerIndex].plays[playIndex]);
      playerIndex = _indexBefore(playerIndex);
      if (_list[playerIndex] == players.last) playIndex--;
    }
    return playList;
  }

  /// Returns the game's current leader.
  Player get leader {
    Player winner = _list[0];
    for (var player in _list) {
      if (player.score > winner.score) winner = player;
    }
    return winner;
  }

  /// Returns the game's players in a list.
  List<Player> get players => _list.toList();

  /// Accepts an optional parameter "order" which defaults to "desc". Returns the game's players
  /// sorted by score in the specified order.
  List<Player> getPlayersSortedByScore({bool ascending = false}) {
    var sortedPlayers = _list.toList();
    if (ascending) {
      sortedPlayers.sort((a, b) => a.score.compareTo(b.score));
    } else {
      sortedPlayers.sort((a, b) => b.score.compareTo(a.score));
    }
    return sortedPlayers;
  }

  /// Returns the longest word played in the game.
  String get longestWord {
    if (plays.isEmpty) return '';

    String longest = plays.first.playedWords.first.word;
    int maxLength = longest.length;

    for (var play in plays) {
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

    String shortest = plays.first.playedWords.first.word;
    int minLength = shortest.length;

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

  /// Returns the highest scoring word played in the game.
  PlayedWord get highestScoringWord {
    if (plays.isEmpty) return PlayedWord();

    PlayedWord highestScoring = PlayedWord();
    int maxScore = 0;

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

  /// Returns the highest scoring turn played in the game.
  Play get highestScoringTurn {
    if (plays.isEmpty) ; // Handle empty list

    // Initialize variables to keep track of the highest-scoring turn and its score
    Play highestScoring = plays.first;
    int maxScore = highestScoring.score;

    // Iterate through plays to find the highest-scoring turn
    for (var play in plays) {
      if (play.score > maxScore) {
        maxScore = play.score;
        highestScoring = play;
      }
    }

    return highestScoring;
  }

  @override
  void nextItem() {
    super.nextItem();
    currentPlayer.startTurn();
  }

  void endTurn() => nextItem();
}

/// Accepts a name (String) and creates a new player with the given name and
/// an empty list of plays.
class Player {
  Player({required this.name});

  final String name;
  List<Play> plays = [];

  /// Returns the longest word played by the player.
  String get longestWord {
    if (plays.isEmpty) return '';

    String longest = plays.first.playedWords.first.word;
    int maxLength = longest.length;

    for (var play in plays) {
      for (var word in play.playedWords) {
        if (word.word.length > maxLength) {
          maxLength = word.word.length;
          longest = word.word;
        }
      }
    }
    return longest;
  }

  /// Returns the highest scoring word played by the player.
  PlayedWord get highestScoringWord {
    if (plays.isEmpty) return PlayedWord();

    PlayedWord highestScoring = PlayedWord();
    int maxScore = 0;

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

  /// Returns the highest scoring turn played by the player.
  Play get highestScoringTurn {
    if (plays.isEmpty) ; // Handle empty list

    // Initialize variables to keep track of the highest-scoring turn and its score
    Play highestScoring = plays.first;
    int maxScore = highestScoring.score;

    // Iterate through plays to find the highest-scoring turn
    for (var play in plays) {
      if (play.score > maxScore) {
        maxScore = play.score;
        highestScoring = play;
      }
    }
    return highestScoring;
  }

  /// Returns the shortest word played by the player.
  String get shortestWord {
    if (plays.isEmpty) return '';

    String shortest = plays.first.playedWords.first.word;
    int minLength = shortest.length;

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
      ScoreMultiplier.singleWord: Color.fromRGBO(255, 255, 255, 0),
      ScoreMultiplier.doubleWord: Color.fromARGB(255, 243, 125, 125),
      ScoreMultiplier.tripleWord: Color.fromARGB(255, 255, 0, 0),
      ScoreMultiplier.doubleLetter: Color.fromARGB(255, 123, 213, 241),
      ScoreMultiplier.tripleLetter: Color.fromARGB(255, 50, 56, 240),
    },
    ScrabbleEdition.twentyFifthAnniversary: {
      ScoreMultiplier.singleLetter: Colors.amber,
      ScoreMultiplier.singleWord: Color.fromRGBO(255, 255, 255, 0),
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
