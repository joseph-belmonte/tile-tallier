import '../../../core/domain/models/game.dart';
import '../../data/helpers/games_table_helper.dart';
import '../../data/helpers/players_table_helper.dart';
import '../models/past_game.dart';
import '../models/player.dart';

/// A repository for interacting with the game storage database.
class PastGameRepository {
  final GameTableHelper _gameTableHelper = GameTableHelper();
  final PlayerTableHelper _playerTableHelper = PlayerTableHelper();

  /// Saves a game to the database.
  Future<void> saveGame(Game game) async {
    try {
      await _gameTableHelper.insertGame(game);
    } catch (e) {
      // Handle or rethrow the error as needed
      throw Exception('Failed to save game: $e');
    }
  }

  /// Toggles the favorite status of a game in the database.
  Future<void> toggleFavorite(String gameId) async {
    try {
      await _gameTableHelper.toggleFavorite(gameId);
    } catch (e) {
      // Handle or rethrow the error as needed
      throw Exception('Failed to toggle favorite status: $e');
    }
  }

  /// Loads a game from the database.
  Future<PastGame> loadGame(String id) async {
    try {
      return await _gameTableHelper.fetchGame(id);
    } catch (e) {
      // Handle or rethrow the error as needed
      throw Exception('Failed to load game: $e');
    }
  }

  /// Loads all games from the database.
  Future<List<PastGame>> loadAllGames() async {
    try {
      return await _gameTableHelper.fetchGames();
    } catch (e) {
      // Handle or rethrow the error as needed
      throw Exception('Failed to load games: $e');
    }
  }

  /// Deletes a specific game from the database.
  Future<void> deleteGame(String id) async {
    try {
      await _gameTableHelper.deleteGame(id);
    } catch (e) {
      // Handle or rethrow the error as needed
      throw Exception('Failed to delete game: $e');
    }
  }

  /// Deletes all games from the database.
  Future<void> deleteAllGames() async {
    try {
      await _gameTableHelper.deleteAllGames();
    } catch (e) {
      // Handle or rethrow the error as needed
      throw Exception('Failed to delete all games: $e');
    }
  }

  /// Fetches all players from the database.
  Future<List<Player>> fetchAllPlayers() async {
    try {
      return await _playerTableHelper.fetchAllPlayers();
    } catch (e) {
      // Handle or rethrow the error as needed
      throw Exception('Failed to fetch players: $e');
    }
  }

  /// Updates a player's name in the database.
  Future<void> updatePlayerName(String playerId, String newName) async {
    try {
      await _playerTableHelper.updatePlayerName(playerId, newName);
    } catch (e) {
      // Handle or rethrow the error as needed
      throw Exception('Failed to update player name: $e');
    }
  }

  /// Searches for a player by name in the database.
  Future<Player?> findPlayerByName(String name) async {
    try {
      return await _playerTableHelper.findPlayerByName(name);
    } catch (e) {
      throw Exception('Failed to find player by name: $e');
    }
  }

  /// Saves a player to the database.
  Future<void> insertPlayer(Player player) async {
    try {
      await _playerTableHelper.insertPlayer(player);
    } catch (e) {
      // Handle or rethrow the error as needed
      throw Exception('Failed to save player: $e');
    }
  }
}
