import 'package:flutter_test/flutter_test.dart';
import 'package:tile_tally/enums/score_multipliers.dart';
import 'package:tile_tally/features/core/domain/models/letter.dart';
import 'package:tile_tally/features/core/domain/models/play.dart';
import 'package:tile_tally/features/core/domain/models/word.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('Bingo functionality works correctly', () {
    final word = Word(
      id: Uuid().v4(),
      playedLetters: [
        Letter(
          id: Uuid().v4(),
          letter: 'a',
          scoreMultiplier: ScoreMultiplier.none,
        ),
      ],
    );

    final noBingo = Play(
      id: Uuid().v4(),
      playedWords: [word],
      isBingo: false,
      timestamp: DateTime.now(),
    );
    expect(noBingo.score, equals(word.score));
    final yesBingo = noBingo.copyWith(isBingo: true);
    expect(yesBingo.score, equals(word.score + 50));
  });
}
