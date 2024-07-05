import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../play_game/domain/models/player.dart';
import 'past_games_provider.dart';

/// A provider that fetches the players from the database.
final playersProvider = FutureProvider<List<Player>>((ref) async {
  final gameRepository = ref.read(pastGamesProvider.notifier);
  return await gameRepository.fetchAllPlayers();
});
