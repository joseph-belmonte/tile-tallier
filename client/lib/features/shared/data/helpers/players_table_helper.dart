import 'package:sqflite/sqflite.dart';
import '../../../../utils/logger.dart';
import '../../../history/domain/models/database_helper.dart';
import '../../../history/domain/models/player.dart';

/// A helper class for interacting with the 'players' table in the database.
class PlayerTableHelper extends DatabaseHelper {
  /// Creates the 'players' table in the database.
  @override
  Future<void> createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE players (
        id TEXT PRIMARY KEY,
        name TEXT UNIQUE
      )
    ''');
  }

  /// Inserts a player into the database.
  Future<void> insertPlayer(Player player, Transaction txn) async {
    final db = txn;
    await db.insert(
      'players',
      player.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetches a player from the database.
  Future<Player?> fetchPlayer(String playerId, Transaction txn) async {
    final db = txn;
    final result =
        await db.query('players', where: 'id = ?', whereArgs: [playerId]);

    if (result.isNotEmpty) {
      return Player.fromJson(result.first);
    } else {
      return null;
    }
  }

  /// Fetches all players from the database.
  Future<List<Player>> fetchAllPlayers() async {
    final db = await database;
    final result = await db.query('players');
    return result.map(Player.fromJson).toList();
  }

  /// Updates a player's name in the database, given their ID.
  Future<void> updatePlayerName(
    String playerId,
    String newName,
    Transaction txn,
  ) async {
    try {
      // First, update the player's name in the 'players' table
      await txn.update(
        'players',
        {'name': newName},
        where: 'id = ?',
        whereArgs: [playerId],
      );
      // Next, update the player's name in the 'game_players' table
      await txn.update(
        'game_players',
        {'name': newName},
        where: 'playerId = ?',
        whereArgs: [playerId],
      );
    } on Exception catch (e) {
      logger.e('Error updating player name: $e');
    }
  }

  /// Fetches a player from the database by their name
  Future<Player?> findPlayer({
    String? id,
    String? name,
  }) async {
    final db = await database;
    if (id != null) {
      final result =
          await db.query('players', where: 'id = ?', whereArgs: [id]);

      if (result.isNotEmpty) {
        return Player.fromJson(result.first);
      }
      return null;
    } else if (name != null) {
      final result =
          await db.query('players', where: 'name = ?', whereArgs: [name]);
      if (result.isNotEmpty) {
        return Player.fromJson(result.first);
      }
      return null;
    }
    return null;
  }

  /// Deletes a player from the database by their ID.
  Future<void> deletePlayer(String id) async {
    final db = await database;
    await db.delete('players', where: 'id = ?', whereArgs: [id]);
  }

  /// Deletes all players from the database.
  Future<void> deleteAllPlayers() async {
    final db = await database;
    await db.delete('players');
  }
}
