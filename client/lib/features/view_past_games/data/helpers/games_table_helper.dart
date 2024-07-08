import 'package:sqflite/sqflite.dart';

import '../../../core/domain/models/game.dart';
import '../../../core/domain/models/game_player.dart';
import '../../../core/domain/models/letter.dart';
import '../../../core/domain/models/play.dart';
import '../../../core/domain/models/word.dart';
import '../../domain/models/past_game.dart';
import 'database_helper.dart';

/// A helper class for interacting with the games table in the database.
class GameTableHelper extends DatabaseHelper {
  /// Creates the 'games' table in the database.
  Future<void> createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE games (
        id TEXT PRIMARY KEY,
        is_favorite INTEGER DEFAULT 0
      )
    ''');
  }

  /// Inserts a game into the database.
  Future<void> insertGame(Game game) async {
    final db = await database;
    await db.insert(
      'games',
      {'id': game.id},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetches a game from the database by its ID.
  Future<PastGame> fetchGame(String id) async {
    final db = await database;
    final gameMap = await db.query('games', where: 'id = ?', whereArgs: [id]);

    if (gameMap.isEmpty) {
      throw Exception('Game not found');
    }

    return await _assembleGame(gameMap.first);
  }

  /// Fetches all games from the database.
  Future<List<PastGame>> fetchGames() async {
    final db = await database;
    final gamesMap = await db.query('games');

    final games = await Future.wait(
      gamesMap.map((gameMap) async {
        return await _assembleGame(gameMap);
      }).toList(),
    );

    return games;
  }

  /// Toggles the favorite status of a game in the database.
  Future<void> toggleFavorite(String id) async {
    final db = await database;
    await db.rawUpdate(
      '''
      UPDATE games
      SET is_favorite = 1 - is_favorite
      WHERE id = ?
    ''',
      [id],
    );
  }

  /// Assembles a [PastGame] object from a game map.
  Future<PastGame> _assembleGame(Map<String, dynamic> gameJson) async {
    final db = await database;

    final gameId = gameJson['id'] as String;

    final playersMap =
        await db.query('players', where: 'gameId = ?', whereArgs: [gameId]);
    final players = await Future.wait(
      playersMap.map((player) async {
        // Create a [GamePlayer] from the player map
        var playerObj = GamePlayer(
          id: player['id'] as String? ?? '',
          playerId: player['playerId'] as String? ?? '',
          gameId: player['gameId'] as String? ?? '',
          name: player['name'] as String? ?? '',
          endRack: player['endRack'] as String? ?? '',
        );

        // Get the plays for this player
        final playsMap = await db
            .query('plays', where: 'playerId = ?', whereArgs: [playerObj.id]);
        final plays = await Future.wait(
          playsMap.map((play) async {
            var playObj = Play.fromJson(play);

            // Fetch words for this play
            final wordsMap = await db
                .query('words', where: 'playId = ?', whereArgs: [playObj.id]);
            final words = await Future.wait(
              wordsMap.map((word) async {
                var wordObj = Word.fromJson(word);

                // Fetch letters for this word
                final lettersMap = await db.query(
                  'playedLetters',
                  where: 'wordId = ?',
                  whereArgs: [wordObj.id],
                );
                final letters = lettersMap.map(Letter.fromJson).toList();

                wordObj = wordObj.copyWith(playedLetters: letters);
                return wordObj;
              }).toList(),
            );

            playObj = playObj.copyWith(playedWords: words);
            return playObj;
          }).toList(),
        );

        playerObj = playerObj.copyWith(plays: plays);
        return playerObj;
      }).toList(),
    );

    final gameJsonMutable = Map<String, dynamic>.from(gameJson);

    // Ensure currentPlay and currentWord are not null
    gameJsonMutable['currentPlay'] =
        gameJson['currentPlay'] ?? Play.createNew().toJson();
    gameJsonMutable['currentWord'] =
        gameJson['currentWord'] ?? Word.createNew().toJson();

    final game = PastGame.fromJson(gameJsonMutable).copyWith(players: players);

    return game;
  }

  /// Deletes a game from the database.
  Future<void> deleteGame(String id) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('games', where: 'id = ?', whereArgs: [id]);
      await txn.delete('game_players', where: 'gameId = ?', whereArgs: [id]);

      final plays =
          await txn.query('plays', where: 'gameId = ?', whereArgs: [id]);
      for (var play in plays) {
        await txn.delete('words', where: 'playId = ?', whereArgs: [play['id']]);
        await txn.delete(
          'playedLetters',
          where: 'wordId IN (SELECT id FROM words WHERE playId = ?)',
          whereArgs: [play['id']],
        );
      }

      await txn.delete('plays', where: 'gameId = ?', whereArgs: [id]);
    });
  }

  /// Deletes all games from the database.
  Future<void> deleteAllGames() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('words');
      await txn.delete('playedLetters');
      await txn.delete('plays');
      await txn.delete('game_players');
      await txn.delete('games');
    });
  }
}
