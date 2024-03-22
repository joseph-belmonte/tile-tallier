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
    @Default(WordScoreMultiplier.singleWord) WordScoreMultiplier wordMultiplier,
  }) = _Word;
  const Word._();

  /// Returns the word as a string.
  String get word => playedLetters.map((e) => e.letter).join();

  /// Returns the total score of the word.
  int get score =>
      playedLetters.fold(0, (total, letter) => total + letter.score) * wordMultiplier.value;
}
