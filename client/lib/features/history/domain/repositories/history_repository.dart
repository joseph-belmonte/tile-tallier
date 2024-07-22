import 'package:sqflite/sqflite.dart';

import '../../../core/domain/models/game.dart';
import '../../../shared/data/helpers/games_table_helper.dart';
import '../../../shared/data/helpers/players_table_helper.dart';
import '../models/player.dart';

/// A repository for interacting with the game storage database.
class HistoryRepository {
  final GameTableHelper _gameTableHelper = GameTableHelper();
  final PlayerTableHelper _playerTableHelper = PlayerTableHelper();
  late final Future<Database> _databaseFuture;

  /// Creates a new [HistoryRepository] instance.
  HistoryRepository(this._databaseFuture);

  /// Gets the database.
  Future<Database> get database async => await _databaseFuture;

  // Region: 'games' table methods
  /// Saves a game to the database.
  Future<void> saveGame(Game game, Transaction txn) async {
    await _gameTableHelper.insertGame(game, txn);
  }

  /// Deletes a specific game from the database.
  Future<void> deleteGame(String id) async {
    await _gameTableHelper.deleteGame(id);
  }

  /// Toggles the favorite status of a game in the database.
  Future<void> toggleFavorite(String id) async {
    await _gameTableHelper.toggleFavorite(id);
  }

  /// Fetches a game from the database.
  Future<Game> fetchGame(String id) async {
    return await _gameTableHelper.fetchGame(id);
  }

  /// Loads all games from the database.
  Future<List<Game>> fetchGames() async {
    return await _gameTableHelper.fetchGames();
  }

  /// Deletes all games from the database.
  Future<void> deleteAllGames() async {
    await _gameTableHelper.deleteAllGames();
  }
  // End region

  // Region: 'players' table methods
  /// Inserts a player into the database.
  Future<void> savePlayer(Player player, Transaction txn) async {
    await _playerTableHelper.insertPlayer(player, txn);
  }

  /// Fetches a player from the database.
  Future<Player?> fetchPlayer(String playerId, Transaction txn) async {
    return await _playerTableHelper.fetchPlayer(playerId, txn);
  }

  /// Fetches all players from the database.
  Future<List<Player>> fetchAllPlayers() async {
    return await _playerTableHelper.fetchAllPlayers();
  }

  /// Updates a player's name in the database.
  Future<void> updatePlayerName({
    required String playerId,
    required String newName,
  }) async {
    final db = await database;
    await db.transaction((txn) async {
      await _playerTableHelper.updatePlayerName(playerId, newName, txn);
    });
  }

  /// Deletes a player from the database.
  Future<void> deletePlayer(String playerId) async {
    await _playerTableHelper.deletePlayer(playerId);
  }

  /// Deletes all players from the database.
  Future<void> deleteAllPlayers() async {
    await _playerTableHelper.deleteAllPlayers();
  }

  // End region

  /// Gets all games played by a specific player.
  Future<List<Game>> fetchGamesByPlayerId(String playerId) async {
    final games = await _gameTableHelper.fetchGamesByPlayerId(playerId);
    return games;
  }

  /// Submit game results and player data
  Future<void> submitGameData(Game completedGame) async {
    final db = await database;
    await db.transaction((txn) async {
      // Save the game
      await saveGame(completedGame, txn);

      // Save the Players
      for (var gamePlayer in completedGame.players) {
        // Check if the player already exists in the database
        final player = await fetchPlayer(gamePlayer.playerId, txn);

        // If the player does not exist, save them to the database
        if (player == null) {
          final newPlayer =
              Player(name: gamePlayer.name, id: gamePlayer.playerId);
          await savePlayer(newPlayer, txn);
        }
      }
    });
  }
}
