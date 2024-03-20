import '../../data/letter_scores.dart';
import '../../../../../enums/score_multipliers.dart';

/// Accepts a letter [String] and an enum value for the letter multiplier.
class Letter {
  /// The letter to display.
  late final String letter;

  /// Creates a new [Letter] instance.
  Letter(String letter) {
    this.letter = letter.toUpperCase();
  }

  /// The letter multiplier for the letter.
  LetterScoreMultiplier letterMultiplier = LetterScoreMultiplier.singleLetter;

  /// Returns the score for the letter.
  int get score => (letterScores[letter] ?? 0) * letterMultiplier.value;

  /// Toggles the letter multiplier between single, double, and triple letter.
  void toggleLetterMultiplier() {
    switch (letterMultiplier) {
      case LetterScoreMultiplier.singleLetter:
        letterMultiplier = LetterScoreMultiplier.doubleLetter;
        break;
      case LetterScoreMultiplier.doubleLetter:
        letterMultiplier = LetterScoreMultiplier.tripleLetter;
        break;
      case LetterScoreMultiplier.tripleLetter:
        letterMultiplier = LetterScoreMultiplier.singleLetter;
        break;
      default:
        throw Exception('Invalid letter multiplier');
    }
  }
}
