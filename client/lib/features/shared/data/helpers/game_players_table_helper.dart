import 'package:sqflite/sqflite.dart';
import '../../../core/domain/models/game_player.dart';
import 'master_database_helper.dart';

/// A helper class for interacting with the game_players table in the database.
class GamePlayerTableHelper {
  /// Inserts a game player into the database.
  Future<void> insertGamePlayer(GamePlayer gamePlayer, Transaction txn) async {
    await txn.insert(
      'game_players',
      {
        'id': gamePlayer.id,
        'playerId': gamePlayer.playerId,
        'gameId': gamePlayer.gameId,
        'name': gamePlayer.name,
        'endRack': gamePlayer.endRack,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetches all game players from the database.
  Future<List<GamePlayer>> fetchGamePlayers({required String gameId}) async {
    final db = await MasterDatabaseHelper.instance.database;
    final result = await db
        .query('game_players', where: 'gameId = ?', whereArgs: [gameId]);
    return result.map(GamePlayer.fromJson).toList();
  }

  /// Deletes all game players from the database by their game ID.
  Future<void> deleteGamePlayers({required String gameId}) async {
    final db = await MasterDatabaseHelper.instance.database;
    await db.delete('game_players', where: 'gameId = ?', whereArgs: [gameId]);
  }
}
