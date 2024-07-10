import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/player.dart';
import '../../domain/repositories/history_repository.dart';

/// A provider that fetches the players from the database.
final playersProvider = FutureProvider<List<Player>>((ref) async {
  return await HistoryRepository().fetchAllPlayers();
});
