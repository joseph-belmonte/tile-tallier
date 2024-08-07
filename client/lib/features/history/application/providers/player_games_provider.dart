import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/domain/models/game.dart';
import 'history_repository_provider.dart';

/// A provider that fetches the games played by a specific player.
final playerGamesProvider =
    FutureProvider.family<List<Game>, String>((ref, playerId) async {
  final historyRepository = ref.watch(historyRepositoryProvider);
  return historyRepository.fetchGames(playerId: playerId);
});
