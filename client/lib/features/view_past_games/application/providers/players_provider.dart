import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/player.dart';
import 'past_game_repository_provider.dart';

/// A provider that fetches the players from the database.
final playersProvider = FutureProvider<List<Player>>((ref) async {
  final pastGameRepository = ref.read(pastGameRepositoryProvider);
  return await pastGameRepository.fetchAllPlayers();
});
