import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../enums/score_multipliers.dart';
import '../../data/letter_scores.dart';

part 'letter.freezed.dart';

/// Represents a single letter in the game.
@freezed
class Letter with _$Letter {
  /// Creates a new [Letter] instance.
  const factory Letter({
    required String letter,
    @Default(ScoreMultiplier.none) ScoreMultiplier scoreMultiplier,
  }) = _Letter;

  const Letter._();

  /// Returns the score of the letter.
  int get score {
    int multiplier;
    switch (scoreMultiplier) {
      case ScoreMultiplier.doubleLetter:
        multiplier = 2;
        break;
      case ScoreMultiplier.tripleLetter:
        multiplier = 3;
        break;
      default:
        multiplier = 1;
    }
    return (letterScores[letter.toUpperCase()] ?? 0).toInt() * multiplier;
  }
}
