import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../enums/score_multipliers.dart';
import 'letter.dart';

part 'word.freezed.dart';

/// Represents a word in the game.
@freezed
class Word with _$Word {
  /// Creates a new [Word] instance.
  const factory Word({
    @Default([]) List<Letter> playedLetters,
  }) = _Word;
  const Word._();

  /// Returns the word as a string.
  String get word => playedLetters.map((e) => e.letter).join();

  /// Returns the total score of the word.
  int get score {
    final baseScore = playedLetters.fold(0, (total, letter) => total + letter.score);
    var wordMultiplier = 1;

    // Check if any letters have word multipliers and apply the highest one.
    for (var letter in playedLetters) {
      if (letter.scoreMultiplier == ScoreMultiplier.doubleWord && wordMultiplier < 2) {
        wordMultiplier = 2;
      } else if (letter.scoreMultiplier == ScoreMultiplier.tripleWord) {
        wordMultiplier = 3;
        break;
      }
    }

    return baseScore * wordMultiplier;
  }
}
