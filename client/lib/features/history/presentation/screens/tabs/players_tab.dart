import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/providers/players_provider.dart';
import '../../../domain/models/player.dart';
import '../player_history_page.dart';

/// Displays all players from the local database.
class PlayersTab extends ConsumerWidget {
  // ignore: public_member_api_docs
  const PlayersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(playersProvider);

    return playersAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('An error occurred while fetching players.'),
          Center(child: Text('Error fetching players, please try again.')),
          Divider(),
        ],
      ),
      data: (List<Player> players) {
        return ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index];
            return ListTile(
              title: Text(player.name),
              subtitle: Text(player.id.substring(0, 8)),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_rounded),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return PlayerHistoryPage(player: player);
                      },
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
