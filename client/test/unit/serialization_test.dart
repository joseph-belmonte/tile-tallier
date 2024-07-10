import 'package:flutter_test/flutter_test.dart';
import 'package:tile_tally/features/core/domain/models/letter.dart';
import 'package:tile_tally/features/core/domain/models/play.dart';
import 'package:tile_tally/features/core/domain/models/word.dart';

void main() {
  test('Play JSON serialization and deserialization', () {
    final letters = [
      Letter.createNew(letter: 'A'),
      Letter.createNew(letter: 'B'),
      Letter.createNew(letter: 'C'),
    ];

    final word = Word.createNew().copyWith(playedLetters: letters);
    final play = Play.createNew(gameId: 'game_1').copyWith(
      playedWords: [word],
    );

    final playJson = play.toJson();
    print('Serialized Play: $playJson');

    final deserializedPlay = Play.fromJson(playJson);
    print('Deserialized Play: $deserializedPlay');

    expect(deserializedPlay, play);
  });
}
