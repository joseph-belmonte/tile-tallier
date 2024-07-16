import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/domain/models/game.dart';
import '../../presentation/controllers/history_page_controller.dart';

/// A provider that exposes the [HistoryPageState] for its [Player]s property.
final pastGamesProvider = Provider<List<Game>>((ref) {
  final historyPageState = ref.watch(historyPageControllerProvider);
  return historyPageState.games;
});
