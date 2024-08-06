import 'package:sqflite/sqflite.dart';

import '../../../../utils/logger.dart';
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

  /// Deletes a specific game from the database.
  Future<void> deleteGame(String gameId) async {
    await _gameTableHelper.deleteGame(gameId);
  }

  /// Toggles the favorite status of a game in the database.
  Future<void> toggleFavorite(String gameId) async {
    await _gameTableHelper.toggleFavorite(gameId);
  }

  /// Fetches a game from the database.
  Future<Game> fetchGame(String gameId) async {
    return await _gameTableHelper.fetchGame(gameId);
  }

  /// Loads all games from the database.
  Future<List<Game>> fetchGames({String? playerId, String? playerName}) async {
    try {
      if (playerId != null) {
        return await _gameTableHelper.fetchGames(playerId: playerId);
      } else if (playerName != null) {
        return await _gameTableHelper.fetchGames(playerName: playerName);
      } else {
        return await _gameTableHelper.fetchGames();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveGame(Game game, Transaction txn) async {
    await _gameTableHelper.insertGame(game: game, txn: txn);
  }

  /// Deletes all games from the database.
  Future<void> deleteAllGames() async {
    await _gameTableHelper.deleteAllGames();
  }
  // End region

  // Region: 'players' table methods
  /// Inserts a player into the database.
  Future<void> savePlayer(Transaction txn, Player player) async {
    await _playerTableHelper.insertPlayer(player, txn);
  }

  /// Fetches a player from the database.
  Future<Player?> fetchPlayer({
    Transaction? txn,
    String? playerId,
    String? playerName,
  }) async {
    if (txn != null) {
      return await _playerTableHelper.fetchPlayer(
        txn,
        playerId: playerId,
        playerName: playerName,
      );
    } else {
      final db = await database;
      return await db.transaction((txn) async {
        return await _playerTableHelper.fetchPlayer(
          txn,
          playerId: playerId,
          playerName: playerName,
        );
      });
    }
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

  /// Submit game results and player data
  Future<void> submitGameData(Game completedGame) async {
    final db = await database;
    logger.d('Before submission transaction');
    await db.transaction((txn) async {
      // Save the game
      await _saveGame(completedGame, txn);
      logger.d('Game saved: ${completedGame.id}');

      // transaction is locking here.

      // Save the Players
      for (var gamePlayer in completedGame.players) {
        // Check if the player already exists in the database
        final player =
            await fetchPlayer(txn: txn, playerId: gamePlayer.playerId);
        logger.d('Player fetched: ${gamePlayer.playerId}');

        // If the player does not exist, save them to the database
        if (player == null) {
          final newPlayer =
              Player(name: gamePlayer.name, id: gamePlayer.playerId);
          await savePlayer(txn, newPlayer);
        }
      }
    });
    logger.d('After submission transaction');
  }
}
