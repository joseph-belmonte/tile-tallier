import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/player_games_provider.dart';
import '../../domain/models/player.dart';
import '../widgets/past_game_list.dart';

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
    final playerGamesState = ref.watch(playerGamesProvider(player.id));

    return Scaffold(
      appBar: AppBar(
        title: Text('${player.name} History'),
      ),
      // Fetch the games specific to this player
      body: playerGamesState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error\n$stackTrace'),
        ),
        data: (games) {
          if (games.isEmpty) {
            return const Center(
              child: Text('No games found for this player.'),
            );
          }
          return PastGameList(games: games);
        },
      ),
    );
  }
}
