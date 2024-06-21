import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../play_game/domain/models/game.dart';
import '../../domain/repositories/game_repository.dart';

/// A provider that fetches the past games from the database.
class PastGamesNotifier extends StateNotifier<AsyncValue<List<Game>>> {
  final GameRepository _gameRepository;

  /// Creates a new [PastGamesNotifier] instance.
  PastGamesNotifier(this._gameRepository) : super(const AsyncLoading()) {
    fetchGames();
  }

  /// Fetches the games from the database.
  Future<void> fetchGames() async {
    try {
      final games = await _gameRepository.loadAllGames();
      state = AsyncValue.data(games);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

/// A provider that provides the past games.
final pastGamesProvider = StateNotifierProvider<PastGamesNotifier, AsyncValue<List<Game>>>((ref) {
  final gameRepository = GameRepository();
  return PastGamesNotifier(gameRepository);
});
