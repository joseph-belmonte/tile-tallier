class GameState {
  GameState({required this.players});
  final List<Player> players;
}

class Player {
  Player({required this.name});

  final String name;
  List<Play> plays = [];
}

class Play {
  Play({required this.playedWords, required this.isBingo});

  List<PlayedWord> playedWords;
  final bool isBingo;
}

class PlayedWord {
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
  PlayedLetter({
    required this.letter,
    required this.isDouble,
    required this.isTriple,
  });

  final String letter;
  final bool isDouble;
  final bool isTriple;
}
