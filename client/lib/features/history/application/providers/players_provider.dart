import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/player.dart';
import '../../domain/repositories/history_repository.dart';
import 'history_repository_provider.dart';

/// A provider that fetches the players from the database.
class PlayersNotifier extends StateNotifier<AsyncValue<List<Player>>> {
  final HistoryRepository _historyRepository;

  /// Creates a new [PlayersNotifier] instance.
  PlayersNotifier(this._historyRepository) : super(const AsyncLoading()) {
    fetchPlayers();
  }

  /// Fetches the [Player]s from the database.
  Future<void> fetchPlayers() async {
    state = const AsyncLoading();
    try {
      final players = await _historyRepository.fetchAllPlayers();
      state = AsyncValue.data(players);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Fetches all [Player]s from the database.
  Future<List<Player>> fetchAllPlayers() async {
    try {
      return await _historyRepository.fetchAllPlayers();
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes a specific players from the database and updates the state.
  Future<void> deletePlayer(String playerId) async {
    try {
      await _historyRepository.deletePlayer(playerId);
      final updatedPlayers =
          state.value!.where((game) => game.id != playerId).toList();
      state = AsyncValue.data(updatedPlayers);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Deletes all players from the database and updates the state.
  Future<void> deleteAllPlayers() async {
    try {
      await _historyRepository.deleteAllPlayers();
      state = const AsyncValue.data([]);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

/// A provider that exposes the [PlayersNotifier].
final playersProvider =
    StateNotifierProvider<PlayersNotifier, AsyncValue<List<Player>>>((ref) {
  final historyRepository = ref.watch(historyRepositoryProvider);
  return PlayersNotifier(historyRepository);
});
