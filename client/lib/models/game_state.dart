class GameState {
  /// Creates a new game state with the given players.
  GameState({required this.players});
  final List<Player> players;
}

class Player {
  /// Creates a new player with the given name and an empty list of plays.
  Player({required this.name});

  final String name;
  List<Play> plays = [];
}

class Play {
  /// Accepts a list of PlayedWord objects and a boolean value for whether or not the play is a bingo.
  /// A word is a list of PlayedLetter objects.
  /// A bingo is when a player uses all 7 letters in their rack in a single turn.
  Play({required this.playedWords, required this.isBingo});

  List<PlayedWord> playedWords;
  final bool isBingo;
}

class PlayedWord {
  /// Accepts a word (list of PlayedLetter objects) and a boolean value for whether or not the word is a double or triple word.
  PlayedWord({
    required this.word,
    required this.isDouble,
    required this.isTriple,
  });

  final List<PlayedLetter> word;
  final bool isDouble;
  final bool isTriple;
}

class PlayedLetter {
  /// Accepts a letter (String) and a boolean value for whether or not the letter is a double or triple letter.
  PlayedLetter({
    required this.letter,
    required this.isDouble,
    required this.isTriple,
  });

  final String letter;
  final bool isDouble;
  final bool isTriple;
}
