import 'package:flutter_test/flutter_test.dart';
import 'package:tile_tally/features/core/domain/models/game.dart';
import 'package:tile_tally/features/core/domain/models/game_player.dart';
import 'package:tile_tally/features/core/domain/models/letter.dart';
import 'package:tile_tally/features/core/domain/models/play.dart';
import 'package:tile_tally/features/core/domain/models/word.dart';
import 'package:tile_tally/features/history/domain/models/player.dart';

import '../mocks/data/game_players.dart';
import '../mocks/data/games.dart';
import '../mocks/data/players.dart';

void main() {
  group('Serialization tests for game and associated models', () {
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

      final deserializedPlay = Play.fromJson(playJson);

      expect(deserializedPlay, play);
    });

    test('Player JSON serialization and deserialization', () {
      final playerJson = player1.toJson();
      final deserializedPlayer = Player.fromJson(playerJson);

      expect(deserializedPlayer, player1);
    });

    test('GamePlayer JSON serialization and deserialization', () {
      final gamePlayerJson = gamePlayer1.toJson();
      final deserializedGamePlayer = GamePlayer.fromJson(gamePlayerJson);

      expect(deserializedGamePlayer, gamePlayer1);
    });

    test('Game JSON serialization and deserialization', () {
      final gameJson = game1.toJson();
      final deserializedGame = Game.fromJson(gameJson);

      final newGame = game1.copyWith(isFavorite: true);
      final newGameJson = newGame.toJson();

      final deserializedNewGame = Game.fromJson(newGameJson);

      expect(deserializedGame, game1);
      expect(deserializedNewGame, newGame);
    });
  });
}
