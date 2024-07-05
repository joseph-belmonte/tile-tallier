import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/player.dart';
import '../../domain/models/past_game.dart';
import '../../domain/repositories/game_repository.dart';

/// A provider that fetches the past games from the database.
class PastGamesNotifier extends StateNotifier<AsyncValue<List<PastGame>>> {
  final PastGameRepository _gameRepository;

  /// Creates a new [PastGamesNotifier] instance.
  PastGamesNotifier(this._gameRepository) : super(const AsyncLoading()) {
    fetchGames();
  }

  /// Fetches the [PastGame]s from the database.
  Future<void> fetchGames() async {
    try {
      final games = await _gameRepository.loadAllGames();
      state = AsyncValue.data(games);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Toggles the favorite status of the game with the given [gameId].
  Future<void> toggleFavorite(String gameId) async {
    try {
      await _gameRepository.toggleFavorite(gameId);
      final updatedGames = state.value!.map((game) {
        if (game.id == gameId) {
          return game.copyWith(isFavorite: !game.isFavorite);
        }
        return game;
      }).toList();
      state = AsyncValue.data(updatedGames);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Fetches all [Player]s from the database.
  Future<List<Player>> fetchAllPlayers() async {
    return await _gameRepository.fetchAllPlayers();
  }
}

/// A provider that provides the past games.
final pastGamesProvider =
    StateNotifierProvider<PastGamesNotifier, AsyncValue<List<PastGame>>>((ref) {
  final pastGameRepository = PastGameRepository();
  return PastGamesNotifier(pastGameRepository);
});
