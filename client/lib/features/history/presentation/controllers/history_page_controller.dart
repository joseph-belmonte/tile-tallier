import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/game.dart';
import '../../application/providers/history_repository_provider.dart';

import '../../domain/models/player.dart';

/// The state of the history page.
class HistoryPageState {
  /// Whether the page is loading.
  final bool isLoading;

  /// The list of games.
  final List<Game> games;

  /// The list of favorite games.
  final List<Game> favoriteGames;

  /// The list of players.
  final List<Player> players;

  /// The error message.
  final String? errorMessage;

  /// Creates a new [HistoryPageState] instance.
  HistoryPageState({
    this.isLoading = true,
    this.games = const [],
    this.favoriteGames = const [],
    this.players = const [],
    this.errorMessage,
  });

  // ignore: public_member_api_docs
  HistoryPageState copyWith({
    bool? isLoading,
    List<Game>? games,
    List<Game>? favoriteGames,
    List<Player>? players,
    String? errorMessage,
  }) {
    return HistoryPageState(
      isLoading: isLoading ?? this.isLoading,
      games: games ?? this.games,
      favoriteGames: favoriteGames ?? this.favoriteGames,
      players: players ?? this.players,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// A controller for the history page.
class HistoryPageController extends StateNotifier<HistoryPageState> {
  /// A reference to the history repository provider.
  final Ref ref;

  /// Creates a new [HistoryPageController] instance.
  HistoryPageController(this.ref) : super(HistoryPageState()) {
    _init();
  }

  Future<void> _init() async {
    await fetchGames();
    await fetchPlayers();
  }

  /// Fetches all games.
  Future<void> fetchGames() async {
    state = state.copyWith(isLoading: true);
    try {
      final games = await ref.read(historyRepositoryProvider).fetchGames();
      state = state.copyWith(games: games, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  /// Fetches all favorite games.
  Future<void> fetchFavoriteGames() async {
    state = state.copyWith(isLoading: true);
    try {
      final games = await ref.read(historyRepositoryProvider).fetchGames();
      final favoriteGames = games.where((game) => game.isFavorite).toList();
      state = state.copyWith(favoriteGames: favoriteGames, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  /// Fetches all players.
  Future<void> fetchPlayers() async {
    state = state.copyWith(isLoading: true);
    try {
      final players =
          await ref.read(historyRepositoryProvider).fetchAllPlayers();
      state = state.copyWith(players: players, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  /// Deletes a game.
  Future<void> deleteGame(String gameId) async {
    await ref.read(historyRepositoryProvider).deleteGame(gameId);
    await fetchGames();
  }

  /// Deletes all games.
  Future<void> deleteAllGames() async {
    await ref.read(historyRepositoryProvider).deleteAllGames();
    await fetchGames();
  }

  /// Deletes all players.
  Future<void> deleteAllPlayers() async {
    await ref.read(historyRepositoryProvider).deleteAllPlayers();
    await fetchPlayers();
  }

  /// Toggles the favorite status of a game.
  Future<void> toggleFavorite(String gameId) async {
    await ref.read(historyRepositoryProvider).toggleFavorite(gameId);
    await fetchGames();
  }

  /// Updates a player's name.
  Future<void> updatePlayerName({
    required String playerId,
    required String newName,
  }) async {
    await ref.read(historyRepositoryProvider).updatePlayerName(
          playerId: playerId,
          newName: newName,
        );
    await fetchPlayers();
  }
}

/// A provider that exposes a [HistoryPageController].
final historyPageControllerProvider =
    StateNotifierProvider<HistoryPageController, HistoryPageState>((ref) {
  return HistoryPageController(ref);
});
