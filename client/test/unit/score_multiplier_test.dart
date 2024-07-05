import 'package:flutter_test/flutter_test.dart';
import 'package:tile_tally/enums/score_multipliers.dart';
import 'package:tile_tally/features/play_game/domain/models/letter.dart';
import 'package:tile_tally/features/play_game/domain/models/word.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('ScoreMultiplier Tests', () {
    test('Score multipliers work correctly', () {
      final word = Word(
        id: '1',
        playedLetters: [
          Letter(
            id: Uuid().v4(),
            letter: 'A',
            scoreMultiplier: ScoreMultiplier.none,
          ),
          Letter(
            id: Uuid().v4(),
            letter: 'B',
            scoreMultiplier: ScoreMultiplier.doubleLetter,
          ),
          Letter(
            id: Uuid().v4(),
            letter: 'C',
            scoreMultiplier: ScoreMultiplier.tripleLetter,
          ),
          Letter(
            id: Uuid().v4(),
            letter: 'D',
            scoreMultiplier: ScoreMultiplier.doubleWord,
          ),
          Letter(
            id: Uuid().v4(),
            letter: 'E',
            scoreMultiplier: ScoreMultiplier.tripleWord,
          ),
        ],
      );
      // [(1) + (3 * 2) + (3 * 3) + (2) + (1)] * 2 * 3 = 57
      expect(word.score, equals(57));
    });
  });
}
