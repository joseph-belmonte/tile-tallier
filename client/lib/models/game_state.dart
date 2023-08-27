class GameState {
  /// Creates a new game state with the given players.
  GameState({required this.players});
  final List<Player> players;

  Player getWinner() {
    Player winner = players[0];
    for (var player in players) {
      if (player.score > winner.score) {
        winner = player;
      }
    }
    return winner;
  }

  final Map<Player, int> playerTurnCounts = {};
}

class Player {
  /// Creates a new player with the given name and an empty list of plays.
  Player({required this.name});

  final String name;
  List<Play> plays = [Play(playedWords: [])];

  int get score {
    var score = 0;
    for (var play in plays) {
      score += play.score;
    }
    return score;
  }
}

class Play {
  /// Accepts a list of PlayedWord objects and a boolean value for whether or not the play is a bingo.
  /// A word is a list of PlayedLetter objects.
  /// A bingo is when a player uses all 7 letters in their rack in a single turn.
  Play({required this.playedWords, this.isBingo = false});

  List<PlayedWord> playedWords = [];
  bool isBingo = false;

  /// Returns the score for the play by summing the scores for each PlayedWord object.
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

enum WordMultiplier { doubleWord, tripleWord, none }

class PlayedWord {
  List<PlayedLetter> playedLetters = [];
  WordMultiplier wordMultiplier = WordMultiplier.none;

  /// Returns the word as a string by converting each PlayedLetter object to its letter property and joining them together.
  String get word => playedLetters.map((e) => e.letter).join();

  /// Returns the score for the word by summing the scores for each PlayedLetter object.
  int get score {
    var score = 0;
    for (var letter in playedLetters) {
      score += letter.score;
    }
    return score * scoreMultiplier;
  }

  /// Returns the score multiplier for the word.
  int get scoreMultiplier {
    switch (wordMultiplier) {
      case WordMultiplier.doubleWord:
        return 2;
      case WordMultiplier.tripleWord:
        return 3;
      default:
        return 1;
    }
  }
}

enum LetterMultiplier { doubleLetter, tripleLetter, none }

class PlayedLetter {
  /// Accepts a letter (String) and a boolean value for whether or not the letter is a double or triple letter.
  PlayedLetter(String letter) {
    this.letter = letter.toUpperCase();
  }

  late final String letter;
  LetterMultiplier letterMultiplier = LetterMultiplier.none;

  /// Returns the score for the letter.
  int get score {
    return (letterScores[letter] ?? 0) * scoreMultiplier;
  }

  /// Returns the score multiplier for the letter.
  int get scoreMultiplier {
    switch (letterMultiplier) {
      case LetterMultiplier.doubleLetter:
        return 2;
      case LetterMultiplier.tripleLetter:
        return 3;
      default:
        return 1;
    }
  }

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
}
