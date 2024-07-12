import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/player.dart';
import '../../presentation/controllers/history_page_controller.dart';

/// A provider that fetches the players from the database.
final playersProvider = Provider<List<Player>>((ref) {
  final historyPageState = ref.watch(historyPageControllerProvider);
  return historyPageState.players;
});
