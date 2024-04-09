import 'package:flutter_test/flutter_test.dart';
import 'package:scrabble_scorer/enums/score_multipliers.dart';
import 'package:scrabble_scorer/features/play_game/domain/models/letter.dart';
import 'package:scrabble_scorer/features/play_game/domain/models/word.dart';

void main() {
  group('ScoreMultiplier Tests', () {
    test('Score multipliers work correctly', () {
      final word = Word(
        playedLetters: [
          Letter(letter: 'A', scoreMultiplier: ScoreMultiplier.none),
          Letter(letter: 'B', scoreMultiplier: ScoreMultiplier.doubleLetter),
          Letter(letter: 'C', scoreMultiplier: ScoreMultiplier.tripleLetter),
          Letter(letter: 'D', scoreMultiplier: ScoreMultiplier.doubleWord),
          Letter(letter: 'E', scoreMultiplier: ScoreMultiplier.tripleWord),
        ],
      );
      // [(1) + (3 * 2) + (3 * 3) + (2) + (1)] * 2 * 3 = 57
      expect(word.score, equals(57));
    });
  });
}
