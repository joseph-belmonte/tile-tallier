import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../utils/logger.dart';
import '../../../application/providers/players_provider.dart';
import '../single_player_history_page.dart';

/// Displays all players from the local database.
class PlayersTab extends ConsumerWidget {
  /// Creates a new [PlayersTab] instance.
  const PlayersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.watch(playersProvider);

    if (players.isEmpty) {
      return const Center(
        child: Text('No players found.'),
      );
    }

    for (var player in players) {
      logger.d('Player: ${player.name}');
    }

    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        logger.i('Player: ${player.name}');
        return ListTile(
          title: Text(player.name),
          subtitle: Text(player.id.substring(0, 8)),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward_rounded),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SinglePlayerHistoryPage(player: player);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
