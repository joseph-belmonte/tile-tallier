import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../../utils/converters.dart';
import 'word.dart';

part 'play.freezed.dart';
part 'play.g.dart';

/// Accepts a list of PlayedWord objects and a boolean value for whether or not
/// the play is a bingo.
/// A word is a list of PlayedLetter objects.
/// A bingo is when a player uses all 7 letters in their rack in a single turn.
@freezed
class Play with _$Play {
  /// Creates a new Play instance.
  factory Play({
    required String id,
    required DateTime timestamp,
    @Default([]) List<Word> playedWords,
    @BoolIntConverter() @Default(false) bool isBingo,
    @Default('') String playerId,
  }) = _Play;

  const Play._();

  /// Creates a new play.
  factory Play.createNew() {
    return Play(id: Uuid().v4(), timestamp: DateTime.now());
  }

  /// Converts Play to a map.
  factory Play.fromJson(Map<String, dynamic> json) => _$PlayFromJson(json);

  /// The total score of the play.
  int get score {
    return playedWords.fold<int>(
          0,
          (previousValue, element) => previousValue + element.score,
        ) +
        (isBingo ? 50 : 0);
  }
}
