import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../utils/logger.dart';
import '../../../auth/application/providers/auth_provider.dart';
import '../../../core/domain/models/game.dart';
import '../../../history/domain/models/player.dart';
import '../../../shared/data/helpers/games_table_helper.dart';
import '../../../shared/data/helpers/players_table_helper.dart';
import '../../../shared/data/sources/local/local_storage_service.dart';
import '../../data/sources/network/gemini_api_service.dart';
import '../../domain/models/stored_advice.dart';

/// A controller for the coaching page.
class CoachingController extends StateNotifier<CoachingPageState> {
  /// Creates a new [CoachingController] instance.
  CoachingController(this._ref)
      : _apiService = GeminiApiService(),
        _gamesTableHelper = GameTableHelper(),
        _playersTableHelper = PlayerTableHelper(),
        _localStorageService = LocalStorageService(
          secureStorage: const FlutterSecureStorage(),
        ),
        super(CoachingPageState());

  /// A reference to the current provider.
  final StateNotifierProviderRef _ref;
  final GeminiApiService _apiService;
  final GameTableHelper _gamesTableHelper;
  final PlayerTableHelper _playersTableHelper;
  final LocalStorageService _localStorageService;

  /// Initializes the controller.
  void init() async {
    state = state.copyWith(
      isLoading: true,
      isAuthenticated: _ref.read(authProvider).isAuthenticated,
    );
    try {
      final players = await _playersTableHelper.fetchAllPlayers();
      state = state.copyWith(players: players, isLoading: false);
    } catch (e) {
      logger.e('Error fetching players: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  /// Selects a player by their ID.
  void selectPlayer(String? playerId) {
    if (playerId == null) return;
    state = state.copyWith(playerId: playerId);
    _fetchAndSetGames(playerId);
    _handleAuthAndFetchAdvice(playerId);
  }

  void _fetchAndSetGames(String playerId) async {
    try {
      final fetchedGames =
          await _gamesTableHelper.fetchGamesByPlayerName(playerId);
      state = state.copyWith(games: fetchedGames);
    } catch (e) {
      logger.e('Error fetching games: $e');
    }
  }

  void _handleAuthAndFetchAdvice(String playerId) async {
    final localAdvice = await _localStorageService.getAdvice(playerId);
    if (localAdvice != null &&
        DateTime.now().difference(localAdvice.lastFetched).inDays < 7) {
      state = state.copyWith(
        advice: localAdvice.adviceText,
        daysUntilNextAdvice:
            7 - DateTime.now().difference(localAdvice.lastFetched).inDays,
      );
      return;
    }
    _fetchAndSetAdvice(playerId);
  }

  void _fetchAndSetAdvice(String playerId) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _apiService.fetchAdvice(playerId);
      final adviceText = response['advice'];
      state = state.copyWith(advice: adviceText, isLoading: false);
      final storedAdvice = StoredAdvice(
        playerId: playerId,
        adviceText: adviceText,
        lastFetched: DateTime.now(),
      );
      await _localStorageService.saveAdvice(storedAdvice);
    } catch (e) {
      logger.e('Error fetching advice: $e');
      state = state.copyWith(advice: 'Error fetching advice', isLoading: false);
    }
  }
}

/// The state for the coaching page.
class CoachingPageState {
  /// Creates a new [CoachingPageState] instance.
  CoachingPageState({
    this.playerId,
    this.players = const [],
    this.games = const [],
    this.advice = '',
    this.isLoading = false,
    this.isAuthenticated = false,
    this.daysUntilNextAdvice = 7,
  });

  /// The ID of the selected player.
  final String? playerId;

  /// The list of players.
  final List<Player> players;

  /// The list of games.
  final List<Game> games;

  /// The advice text.
  final String advice;

  /// The number of days until the next advice.
  final int? daysUntilNextAdvice;

  /// Whether the page is loading.
  final bool isLoading;

  /// Whether the user is authenticated.
  final bool isAuthenticated;

  /// Creates a copy of this state with the given fields replaced with the new values.
  CoachingPageState copyWith({
    String? playerId,
    List<Player>? players,
    List<Game>? games,
    String? advice,
    int? daysUntilNextAdvice,
    bool? isLoading,
    bool? isAuthenticated,
  }) {
    return CoachingPageState(
      playerId: playerId ?? this.playerId,
      players: players ?? this.players,
      games: games ?? this.games,
      advice: advice ?? this.advice,
      daysUntilNextAdvice: daysUntilNextAdvice ?? this.daysUntilNextAdvice,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

/// The provider for the coaching controller.
final coachingControllerProvider =
    StateNotifierProvider<CoachingController, CoachingPageState>((ref) {
  return CoachingController(ref);
});
