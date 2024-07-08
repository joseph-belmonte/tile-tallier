import 'package:sqflite/sqflite.dart';

import '../../../play_game/domain/models/game_player.dart';
import 'database_helper.dart';

/// A helper class for interacting with the game_players table in the database.
class GamePlayerTableHelper extends DatabaseHelper {
  /// Creates the 'game_players' table in the database.
  Future<void> createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE game_players (
        id TEXT PRIMARY KEY,
        playerId TEXT,
        gameId TEXT,
        name TEXT,
        endRack TEXT,
        FOREIGN KEY (playerId) REFERENCES players (id),
        FOREIGN KEY (gameId) REFERENCES games (id)
      )
    ''');
  }

  /// Inserts a game player into the database.
  Future<void> insertGamePlayer(GamePlayer gamePlayer) async {
    final db = await database;
    await db.insert(
      'game_players',
      gamePlayer.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetches all game players from the database.
  Future<List<GamePlayer>> fetchGamePlayersByGameId(String gameId) async {
    final db = await database;
    final result = await db
        .query('game_players', where: 'gameId = ?', whereArgs: [gameId]);
    return result.map(GamePlayer.fromJson).toList();
  }

  /// Deletes all game players from the database by their game ID.
  Future<void> deleteGamePlayersByGameId(String gameId) async {
    final db = await database;
    await db.delete('game_players', where: 'gameId = ?', whereArgs: [gameId]);
  }
}
