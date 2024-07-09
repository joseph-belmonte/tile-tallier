import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/logger.dart';

import '../../../core/domain/models/game.dart';
import '../../domain/models/player.dart';
import '../../domain/repositories/history_repository.dart';
import 'history_repository_provider.dart';

/// A provider that fetches the past games from the database.
class PastGamesNotifier extends StateNotifier<AsyncValue<List<Game>>> {
  final HistoryRepository _historyRepository;

  /// Creates a new [PastGamesNotifier] instance.
  PastGamesNotifier(this._historyRepository) : super(const AsyncLoading()) {
    fetchGames();
  }

  /// Fetches the [Game]s from the database.
  Future<void> fetchGames() async {
    state = const AsyncLoading();
    try {
      final games = await _historyRepository.fetchGames();
      state = AsyncValue.data(games);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      logger.e('Failed to fetch games $e + $stackTrace');
    }
  }

  /// Toggles the favorite status of a specific game in the database.
  Future<void> toggleFavorite(String gameId) async {
    try {
      await _historyRepository.toggleFavorite(gameId);
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

  /// Deletes a specific game from the database and updates the state.
  Future<void> deleteGame(String gameId) async {
    try {
      await _historyRepository.deleteGame(gameId);
      final updatedGames =
          state.value!.where((game) => game.id != gameId).toList();
      state = AsyncValue.data(updatedGames);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Deletes all games from the database and updates the state.
  Future<void> deleteAllGames() async {
    try {
      await _historyRepository.deleteAllGames();
      state = const AsyncValue.data([]);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Fetches all [Player]s from the database.
  Future<List<Player>> fetchAllPlayers() async {
    return await _historyRepository.fetchAllPlayers();
  }
}

/// A provider that exposes the [PastGamesNotifier].
final pastGamesProvider =
    StateNotifierProvider<PastGamesNotifier, AsyncValue<List<Game>>>((ref) {
  final historyRepository = ref.watch(historyRepositoryProvider);
  return PastGamesNotifier(historyRepository);
});
