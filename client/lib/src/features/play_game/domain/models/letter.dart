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
    @Default(LetterScoreMultiplier.singleLetter) LetterScoreMultiplier letterMultiplier,
  }) = _Letter;
  const Letter._();

  /// Returns the score of the letter.
  int get score => (letterScores[letter.toUpperCase()] ?? 0).toInt() * letterMultiplier.value;
}
