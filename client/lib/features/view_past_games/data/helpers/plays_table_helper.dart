import 'package:sqflite/sqflite.dart';

import '../../../core/domain/models/play.dart';
import 'database_helper.dart';

/// A helper class for interacting with the 'plays' table in the database.
class PlayTableHelper extends DatabaseHelper {
  /// Creates the 'plays' table in the database.
  @override
  Future<void> createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE plays (
        id TEXT PRIMARY KEY,
        playerId TEXT,
        gameId TEXT,
        isBingo INTEGER,
        timestamp TEXT,
        FOREIGN KEY (playerId) REFERENCES game_players (id),
        FOREIGN KEY (gameId) REFERENCES games (id)
      )
    ''');
  }

  /// Inserts a play into the database.
  Future<void> insertPlay(Play play) async {
    final db = await database;
    await db.insert(
      'plays',
      play.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetches all plays by one [Player] from the database, given their ID.
  Future<List<Play>> fetchPlaysByPlayerId(String playerId) async {
    final db = await database;
    final result =
        await db.query('plays', where: 'playerId = ?', whereArgs: [playerId]);
    return result.map(Play.fromJson).toList();
  }

  /// Deletes all plays from a game by its gameid.
  Future<void> deletePlaysByGameId(String gameId) async {
    final db = await database;
    await db.delete('plays', where: 'gameId = ?', whereArgs: [gameId]);
  }
}
