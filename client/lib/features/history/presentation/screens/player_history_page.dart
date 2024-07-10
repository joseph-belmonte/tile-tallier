import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../play_game/presentation/screens/player_results.dart';
import '../../application/providers/past_games_provider.dart';
import '../../domain/models/player.dart';

/// A page that displays a list of all games that a player has played.
/// Perhaps put some personal stats here in the future.
/// Ex: Win rate, average score, average rank, etc.
/// should have a button to edit the player name
class PlayerHistoryPage extends ConsumerWidget {
  /// The [Player] whose history is displayed.
  final Player player;

  /// Creates a new [PlayerHistoryPage] instance.
  const PlayerHistoryPage({required this.player, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastGamesState = ref.watch(pastGamesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('${player.name} History'),
      ),
      // Fetch the games specific to this player
      body: pastGamesState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error\n$stackTrace'),
        ),
        data: (games) {
          final playerGames = games.where((game) {
            return game.players.any((p) => p.id == player.id);
          }).toList();

          return ListView.builder(
            itemCount: playerGames.length,
            itemBuilder: (_, int i) {
              final game = playerGames[i];
              final date =
                  game.plays.first.timestamp.toLocal().toString().split(' ')[0];

              return ListTile(
                title: Text('Game on $date'),
                onTap: () {
                  Navigator.of(context).push<void>(
                    MaterialPageRoute(
                      builder: (_) => PlayerResultsScreen(
                        game: game,
                        player: game.players.firstWhere(
                          (p) => p.id == player.id,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
