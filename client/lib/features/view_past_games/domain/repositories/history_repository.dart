import '../../../../utils/logger.dart';
import '../../../core/domain/models/game.dart';
import '../../data/helpers/games_table_helper.dart';
import '../../data/helpers/players_table_helper.dart';
import '../models/player.dart';

/// A repository for interacting with the game storage database.
class HistoryRepository {
  final GameTableHelper _gameTableHelper = GameTableHelper();
  final PlayerTableHelper _playerTableHelper = PlayerTableHelper();

  // Region: 'games' table methods
  /// Saves a game to the database.
  Future<void> saveGame(Game game) async {
    try {
      await _gameTableHelper.insertGame(game);
    } catch (e) {
      // Handle or rethrow the error as needed
      throw Exception('Failed to save game: $e');
    }
  }

  /// Deletes a specific game from the database.
  Future<void> deleteGame(String id) async {
    try {
      logger.d('Deleting game with ID: $id');
      await _gameTableHelper.deleteGame(id);
      logger.d('Deleted game with ID: $id');
    } catch (e) {
      logger.d('Failed to delete game with ID $id: $e');
      throw Exception('Failed to delete game: $e');
    }
  }

  /// Toggles the favorite status of a game in the database.
  Future<void> toggleFavorite(String id) async {
    await _gameTableHelper.toggleFavorite(id);
  }

  /// Loads all games from the database.
  Future<List<Game>> loadAllGames() async {
    return await _gameTableHelper.fetchGames();
  }

  /// Deletes all games from the database.
  Future<void> deleteAllGames() async {
    await _gameTableHelper.deleteAllGames();
  }

  /// Fetches all players from the database.
  Future<List<Player>> fetchAllPlayers() async {
    return await _playerTableHelper.fetchAllPlayers();
  }

  /// Updates a player's name in the database.
  Future<void> updatePlayerName(String playerId, String newName) async {
    await _playerTableHelper.updatePlayerName(playerId, newName);
  }
}
