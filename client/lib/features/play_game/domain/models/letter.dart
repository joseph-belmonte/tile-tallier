import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../enums/score_multipliers.dart';
import '../../../../utils/converters.dart';
import '../../data/letter_scores.dart';

part 'letter.freezed.dart';
part 'letter.g.dart';

/// Represents a single letter in the game.
@freezed
class Letter with _$Letter {
  /// Creates a new [Letter] instance.
  factory Letter({
    required String id,
    required String letter,
    @ScoreMultiplierConverter()
    @Default(ScoreMultiplier.none)
    ScoreMultiplier scoreMultiplier,
  }) = _Letter;

  const Letter._();

  /// Creates a new [Letter] instance with a unique id.
  factory Letter.createNew({
    required String letter,
    ScoreMultiplier scoreMultiplier = ScoreMultiplier.none,
  }) {
    return Letter(
      id: Uuid().v4(),
      letter: letter,
      scoreMultiplier: scoreMultiplier,
    );
  }

  /// Converts the game to a map.
  factory Letter.fromJson(Map<String, dynamic> json) => _$LetterFromJson(json);

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
