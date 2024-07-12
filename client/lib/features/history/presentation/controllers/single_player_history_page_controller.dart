import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/game.dart';
import '../../application/providers/history_repository_provider.dart';
import '../../domain/models/player.dart';

/// The state of the history page.
class SinglePlayerHistoryPageState {
  /// Whether the page is loading.
  final bool isLoading;

  /// The current Player.
  final Player? player;

  /// The list of games played by the player.
  final List<Game> games;

  /// The error message.
  final String? errorMessage;

  /// Creates a new [SinglePlayerHistoryPageState] instance.
  SinglePlayerHistoryPageState({
    this.player,
    this.games = const [],
    this.isLoading = true,
    this.errorMessage,
  });

  // ignore: public_member_api_docs
  SinglePlayerHistoryPageState copyWith({
    bool? isLoading,
    Player? player,
    List<Game>? games,
    String? errorMessage,
  }) {
    return SinglePlayerHistoryPageState(
      isLoading: isLoading ?? this.isLoading,
      player: player ?? this.player,
      games: games ?? this.games,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// A controller for the single player's history page.
class SinglePlayerHistoryPageController
    extends StateNotifier<SinglePlayerHistoryPageState> {
  /// A reference to the history repository provider.
  final Ref ref;

  /// Creates a new [SinglePlayerHistoryPageController] instance.
  SinglePlayerHistoryPageController(this.ref)
      : super(SinglePlayerHistoryPageState());

  /// Fetches the player by their ID.
  Future<void> fetchPlayer(String playerId) async {
    state = state.copyWith(isLoading: true);
    try {
      final db = await ref.read(historyRepositoryProvider).database;
      final player = await db.transaction((txn) async {
        return await ref
            .read(historyRepositoryProvider)
            .fetchPlayer(playerId, txn);
      });

      state = state.copyWith(player: player, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  /// Fetches all games played by the player.
  Future<void> fetchPlayerGames(String playerId) async {
    state = state.copyWith(isLoading: true);
    try {
      final games = await ref
          .read(historyRepositoryProvider)
          .fetchGamesByPlayerId(playerId);
      state = state.copyWith(games: games, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  /// Updates the name of a player.
  Future<void> updatePlayerName({
    required String playerId,
    required String newName,
  }) async {
    try {
      await ref.read(historyRepositoryProvider).updatePlayerName(
            playerId: playerId,
            newName: newName,
          );
      await fetchPlayer(
        playerId,
      ); // Fetch the updated player data to refresh the UI
      await fetchPlayerGames(
        playerId,
      ); // Fetch the updated games list to refresh the UI
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

/// A provider that exposes a [SinglePlayerHistoryPageController].
final singlePlayerHistoryPageControllerProvider = StateNotifierProvider<
    SinglePlayerHistoryPageController, SinglePlayerHistoryPageState>((ref) {
  return SinglePlayerHistoryPageController(ref);
});
