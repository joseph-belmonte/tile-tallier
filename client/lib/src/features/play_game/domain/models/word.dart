import '../../../../../enums/score_multipliers.dart';
import 'letter.dart';

/// Accepts a list of PlayedLetter objects and an enum value for the word
/// multiplier.
class Word {
  /// The list of PlayedLetter objects that make up the word.
  List<Letter> playedLetters;

  /// The word multiplier for the word.
  WordScoreMultiplier wordMultiplier;

  /// Creates a new Word instance.
  Word({
    this.playedLetters = const [],
    this.wordMultiplier = WordScoreMultiplier.singleWord,
  });

  /// Returns the word as a string by converting each PlayedLetter object to its letter property and joining them together.
  String get word => playedLetters.map((e) => e.letter).join();

  /// Returns the score for the word by summing the scores for each PlayedLetter object.
  int get score {
    var score = 0;
    for (var letter in playedLetters) {
      score += letter.score;
    }
    return score * wordMultiplier.value;
  }

  /// Toggles the word multiplier between single, double, and triple word.
  void toggleWordMultiplier() {
    switch (wordMultiplier) {
      case WordScoreMultiplier.singleWord:
        wordMultiplier = WordScoreMultiplier.doubleWord;
      case WordScoreMultiplier.doubleWord:
        wordMultiplier = WordScoreMultiplier.tripleWord;
      case WordScoreMultiplier.tripleWord:
        wordMultiplier = WordScoreMultiplier.singleWord;
      default:
        throw Exception('Invalid word multiplier');
    }
  }

  /// Updates the played letters based on input text.
  void updateCurrentWord(String text) {
    playedLetters = text.split('').map((e) => Letter(e)).toList();
  }
}
