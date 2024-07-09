import 'package:flutter_test/flutter_test.dart';
import 'package:tile_tally/features/core/domain/models/letter.dart';
import 'package:tile_tally/features/core/domain/models/word.dart';
import 'package:tile_tally/utils/logger.dart';

void main() {
  test('Serialization is working correctly', () {
    final letters = [
      Letter.createNew(letter: 'A'),
      Letter.createNew(letter: 'B'),
      Letter.createNew(letter: 'C'),
    ];

    final letter = letters[0];
    final serializedLetter = letter.toJson();
    logger.d('Serialized Letter: $serializedLetter');
    final deserializedLetter = Letter.fromJson(serializedLetter);
    logger.d('Deserialized Letter: $deserializedLetter');
    expect(deserializedLetter, equals(letter));

    final word = Word.createNew().copyWith(playedLetters: letters);
    final serializedWord = word.toJson();
    logger.d('Serialized Word: $serializedWord');
    final deserializedWord = Word.fromJson(serializedWord);
    logger.d('Deserialized Word: $deserializedWord');
    expect(deserializedWord, equals(word));
  });
}
