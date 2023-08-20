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
}

class Player {
  /// Creates a new player with the given name and an empty list of plays.
  Player({required this.name});

  final String name;
  List<Play> plays = [];

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

  List<PlayedWord> playedWords;
  bool isBingo = false;

  int get score {
    var score = 0;
    for (var word in playedWords) {
      score += word.score;
    }
    if (isBingo) score += 50;
    return score;
  }
}

class PlayedWord {
  /// Accepts a word (list of PlayedLetter objects) and a boolean value for whether or not the word is a double or triple word.
  PlayedWord(this.playedLetters);

  final List<PlayedLetter> playedLetters;
  bool isDouble = false;
  bool isTriple = false;

  String get word => playedLetters.map((e) => e.letter).join();

  int get score {
    var score = 0;
    for (var letter in playedLetters) {
      score += letter.score;
    }
    return score * scoreMultiplier;
  }

  int get scoreMultiplier {
    if (isDouble) return 2;
    if (isTriple) return 3;
    return 1;
  }
}

class PlayedLetter {
  /// Accepts a letter (String) and a boolean value for whether or not the letter is a double or triple letter.
  PlayedLetter(String letter) {
    this.letter = letter.toUpperCase();
  }

  late final String letter;
  bool isDouble = false;
  bool isTriple = false;
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

  int get score {
    return (letterScores[letter] ?? 0) * scoreMultiplier;
  }

  int get scoreMultiplier {
    if (isDouble) return 2;
    if (isTriple) return 3;
    return 1;
  }
}
