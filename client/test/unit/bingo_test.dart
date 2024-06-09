import 'package:flutter_test/flutter_test.dart';
import 'package:tile_tally/enums/score_multipliers.dart';
import 'package:tile_tally/features/play_game/domain/models/letter.dart';
import 'package:tile_tally/features/play_game/domain/models/play.dart';
import 'package:tile_tally/features/play_game/domain/models/word.dart';

void main() {
  test('Bingo functionality works correctly', () {
    final word = Word(playedLetters: [Letter(letter: 'a', scoreMultiplier: ScoreMultiplier.none)]);

    final noBingo = Play(playedWords: [word], isBingo: false);
    expect(noBingo.score, equals(word.score));
    final yesBingo = noBingo.copyWith(isBingo: true);
    expect(yesBingo.score, equals(word.score + 50));
  });
}
