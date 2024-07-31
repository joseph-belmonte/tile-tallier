import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../utils/logger.dart';
import '../../../../utils/toast.dart';
import '../../../auth/application/providers/auth_provider.dart';
import '../../../core/domain/models/game.dart';
import '../../../history/domain/models/player.dart';
import '../../../shared/data/helpers/games_table_helper.dart';
import '../../../shared/data/helpers/players_table_helper.dart';
import '../../../shared/data/sources/local/local_storage_service.dart';
import '../../data/sources/network/gemini_api_service.dart';
import '../../domain/models/stored_advice.dart';
import '../widgets/ai_intro.dart';

/// A page for coaching users on how to play the game using the gemini API.
class CoachingPage extends ConsumerStatefulWidget {
  /// Creates a new [CoachingPage] instance.
  const CoachingPage({super.key});

  @override
  ConsumerState<CoachingPage> createState() => _CoachingPageState();
}

class _CoachingPageState extends ConsumerState<CoachingPage> {
  final GeminiApiService _apiService = GeminiApiService();
  final GameTableHelper _gamesTableHelper = GameTableHelper();
  final PlayerTableHelper _playersTableHelper = PlayerTableHelper();
  final LocalStorageService _localStorageService = LocalStorageService(
    secureStorage: FlutterSecureStorage(),
  );

  String? _playerId;
  List<Player> players = [];
  List<Game> games = [];
  String advice = '';
  bool isLoading = false;
  late bool isAuthenticated;

  @override
  void initState() {
    super.initState();
    isAuthenticated = ref.read(authProvider).isAuthenticated;
    _init();
  }

  Future<void> _init() async {
    setState(() => isLoading = true);
    try {
      players = await _playersTableHelper.fetchAllPlayers();
    } catch (e) {
      logger.e('Error fetching players: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _onSelectPlayer(String? playerId) {
    if (playerId == null) return;

    _setSelectedPlayer(playerId);
    final name = _getPlayerNameById(playerId);

    _fetchAndSetGames(name);
    _handleAuthAndFetchAdvice(playerId);
  }

  void _setSelectedPlayer(String playerId) {
    setState(() => _playerId = playerId);
  }

  String _getPlayerNameById(String playerId) {
    return players.firstWhere((player) => player.id == playerId).name;
  }

  Future<void> _fetchAndSetGames(String playerName) async {
    try {
      final fetchedGames =
          await _gamesTableHelper.fetchGamesByPlayerName(playerName);
      setState(() => games = fetchedGames);
    } catch (e) {
      logger.e('Error fetching games: $e');
    }
  }

  Future<void> _handleAuthAndFetchAdvice(String playerId) async {
    final localAdvice = await _localStorageService.getAdvice(playerId);
    if (localAdvice != null &&
        DateTime.now().difference(localAdvice.lastFetched).inDays < 7) {
      setState(() => advice = localAdvice.adviceText);
      if (context.mounted) {
        _showSnackbar(
          // ignore: use_build_context_synchronously
          context,
          'Get new advice in ${7 - DateTime.now().difference(localAdvice.lastFetched).inDays} days',
        );
      }
      return;
    }
    _fetchAndSetAdvice(playerId);
  }

  Future<void> _fetchAndSetAdvice(String playerId) async {
    setState(() => isLoading = true);
    try {
      final response = await _apiService.fetchAdvice(playerId);
      final adviceText = response['advice'];
      setState(() {
        advice = adviceText;
        isLoading = false;
      });
      final storedAdvice = StoredAdvice(
        playerId: playerId,
        adviceText: adviceText,
        lastFetched: DateTime.now(),
      );
      await _localStorageService.saveAdvice(storedAdvice);
    } catch (e) {
      logger.e('Error fetching advice: $e');
      setState(() {
        advice = 'Error fetching advice';
        isLoading = false;
      });
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ToastService.message(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coaching')),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Wrap(
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AIIntro(),
                  ),
                ],
              ),
              _buildPlayerSelection(context),
              Visibility(
                visible: !isLoading,
                replacement: const Center(child: CircularProgressIndicator()),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(advice),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Check back next week for more advice!'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Text(
                  'Note: coach is based on Google\'s Gemini AI model and may provide incorrect advice',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSelection(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Select a player:',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(width: 24.0),
        DropdownButton<String>(
          value: _playerId,
          onChanged: isAuthenticated ? _onSelectPlayer : null,
          items: players.map((Player player) {
            return DropdownMenuItem<String>(
              value: player.id,
              child: Text(
                player.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
