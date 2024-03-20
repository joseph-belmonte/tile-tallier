import '../../enums/score_multipliers.dart';

/// Accepts a [LetterScoreMultiplier] or [WordScoreMultiplier] and returns the text to display.
String getMultiplierText(dynamic multiplier) {
  switch (multiplier) {
    case LetterScoreMultiplier.singleLetter:
      return '1x';
    case WordScoreMultiplier.singleWord:
      return '1x';
    case LetterScoreMultiplier.doubleLetter:
      return '2x';
    case WordScoreMultiplier.doubleWord:
      return '2x';
    case LetterScoreMultiplier.tripleLetter:
      return '3x';
    case WordScoreMultiplier.tripleWord:
      return '3x';
    default:
      throw Exception('Invalid multiplier: $multiplier');
  }
}
