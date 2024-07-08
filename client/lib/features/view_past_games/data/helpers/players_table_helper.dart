import 'package:sqflite/sqflite.dart';
import '../../domain/models/player.dart';
import 'database_helper.dart';

/// A helper class for interacting with the 'players' table in the database.
class PlayerTableHelper extends DatabaseHelper {
  /// Creates the 'players' table in the database.
  Future<void> createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE players (
        id TEXT PRIMARY KEY,
        name TEXT UNIQUE
      )
    ''');
  }

  /// Inserts a player into the database.
  Future<void> insertPlayer(Player player) async {
    final db = await database;
    await db.insert(
      'players',
      player.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetches all players from the database.
  Future<List<Player>> fetchAllPlayers() async {
    final db = await database;
    final result = await db.query('players');
    return result.map(Player.fromJson).toList();
  }

  /// Updates a player's name in the database, given their ID.
  Future<void> updatePlayerName(String playerId, String newName) async {
    final db = await database;
    await db.update(
      'players',
      {'name': newName},
      where: 'id = ?',
      whereArgs: [playerId],
    );
  }

  /// Fetches a player from the database by their name
  Future<Player?> findPlayerByName(String name) async {
    final db = await database;
    final result =
        await db.query('players', where: 'name = ?', whereArgs: [name]);
    if (result.isNotEmpty) {
      return Player.fromJson(result.first);
    }
    return null;
  }

  /// Deletes a player from the database by their ID.
  Future<void> deletePlayer(String id) async {
    final db = await database;
    await db.delete('players', where: 'id = ?', whereArgs: [id]);
  }
}
