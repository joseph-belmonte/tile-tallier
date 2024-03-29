import 'package:freezed_annotation/freezed_annotation.dart';
import 'word.dart';

part 'play.freezed.dart';

/// Accepts a list of PlayedWord objects and a boolean value for whether or not
/// the play is a bingo.
/// A word is a list of PlayedLetter objects.
/// A bingo is when a player uses all 7 letters in their rack in a single turn.
@freezed
class Play with _$Play {
  /// Creates a new Play instance.
  const factory Play({
    @Default([]) List<Word> playedWords,
    @Default(false) bool isBingo,
    @Default('') String playerId,
    DateTime? timestamp,
  }) = _Play;
  const Play._();

  /// The total score of the play.
  int get score {
    return playedWords.fold<int>(
          0,
          (previousValue, element) => previousValue + element.score,
        ) +
        (isBingo ? 50 : 0);
  }
}
