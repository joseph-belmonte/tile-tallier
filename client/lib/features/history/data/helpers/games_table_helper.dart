import 'package:sqflite/sqflite.dart';
import '../../../core/domain/models/game.dart';
import '../../../core/domain/models/game_player.dart';
import '../../../core/domain/models/letter.dart';
import '../../../core/domain/models/play.dart';
import '../../../core/domain/models/word.dart';
import '../../domain/models/database_helper.dart';

import 'plays_table_helper.dart';

/// A helper class for interacting with the games table in the database.
class GameTableHelper extends DatabaseHelper {
  final _playTableHelper = PlayTableHelper();

  /// Creates the 'games' table in the database.
  @override
  Future<void> createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE games (
        id TEXT PRIMARY KEY,
        is_favorite INTEGER DEFAULT 0
      )
    ''');
  }

  /// Inserts a game into the database.
  Future<void> insertGame(Game game, Transaction txn) async {
    await txn.insert(
      'games',
      {'id': game.id},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    for (var player in game.players) {
      await txn.insert(
        'game_players',
        {
          'id': player.id,
          'playerId': player.playerId,
          'gameId': game.id,
          'name': player.name,
          'endRack': player.endRack,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      for (var play in player.plays) {
        for (var word in play.playedWords) {
          for (var letter in word.playedLetters) {
            await txn.insert(
              'playedLetters',
              {
                'id': letter.id,
                'wordId': word.id,
                'letter': letter.letter,
                'scoreMultiplier': letter.scoreMultiplier.index,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }

          await txn.insert(
            'words',
            {
              'id': word.id,
              'playId': play.id,
              'word': word.word,
              'score': word.score,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }

        await _playTableHelper.insertPlay(play, txn);
      }
    }
  }

  /// Fetches a game from the database by its ID.
  Future<Game> fetchGame(String id) async {
    final db = await database;
    final gameMap = await db.query('games', where: 'id = ?', whereArgs: [id]);

    if (gameMap.isEmpty) {
      throw Exception('Game with id $id not found');
    }

    return await assembleGame(gameMap.first);
  }

  /// Fetches all games from the database.
  Future<List<Game>> fetchGames() async {
    final db = await database;
    final gamesMap = await db.query('games');

    final games = await Future.wait(
      gamesMap.map((gameMap) async {
        return await assembleGame(gameMap);
      }).toList(),
    );

    return games;
  }

  /// Toggles the favorite status of a game in the database.
  Future<void> toggleFavorite(String id, Transaction txn) async {
    final db = txn;

    await db.rawUpdate(
      '''
      UPDATE games
      SET is_favorite = 1 - is_favorite
      WHERE id = ?
    ''',
      [id],
    );
  }

  /// Assembles a [Game] object from a game map.
  Future<Game> assembleGame(Map<String, dynamic> gameJson) async {
    final db = await database;

    final gameId = gameJson['id'] as String;

    // Fetch game players from the 'game_players' table
    final playersMap = await db.query(
      'game_players',
      where: 'gameId = ?',
      whereArgs: [gameId],
    );

    final players = await Future.wait(
      playersMap.map((playerMap) async {
        final playerId = playerMap['id'] as String;

        // Get the plays for this game player
        final playsMap = await db.query(
          'plays',
          where: 'playerId = ?',
          whereArgs: [playerId],
        );

        final plays = await Future.wait(
          playsMap.map((playMap) async {
            final play = Play.fromJson(playMap);

            // Fetch words for this play
            final wordsMap = await db.query(
              'words',
              where: 'playId = ?',
              whereArgs: [play.id],
            );

            final words = await Future.wait(
              wordsMap.map((wordMap) async {
                final word = Word.fromJson(wordMap);

                // Fetch letters for this word
                final lettersMap = await db.query(
                  'playedLetters',
                  where: 'wordId = ?',
                  whereArgs: [word.id],
                );

                final letters = lettersMap.map(Letter.fromJson).toList();

                return word.copyWith(playedLetters: letters);
              }).toList(),
            );

            return play.copyWith(playedWords: words);
          }).toList(),
        );

        return GamePlayer.fromJson(playerMap).copyWith(plays: plays);
      }).toList(),
    );

    return Game.fromJson(gameJson).copyWith(players: players);
  }

  /// Deletes a game from the database.
  Future<void> deleteGame(String id, Transaction txn) async {
    final db = txn;
    await db.delete('game_players', where: 'gameId = ?', whereArgs: [id]);
    final plays = await db.query('plays', where: 'gameId = ?', whereArgs: [id]);
    for (var play in plays) {
      await db.delete('words', where: 'playId = ?', whereArgs: [play['id']]);
      await db.delete(
        'playedLetters',
        where: 'wordId IN (SELECT id FROM words WHERE playId = ?)',
        whereArgs: [play['id']],
      );
    }
    await db.delete('plays', where: 'gameId = ?', whereArgs: [id]);
    await db.delete('games', where: 'id = ?', whereArgs: [id]);
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
