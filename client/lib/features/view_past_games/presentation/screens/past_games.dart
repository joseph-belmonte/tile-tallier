import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/past_games_provider.dart';
import '../../data/game_storage_database_helper.dart';
import '../../domain/models/past_game.dart';
import 'past_game.dart';

/// A page that displays the past games.
class PastGamesPage extends ConsumerWidget {
  /// Creates a new [PastGamesPage] instance.
  const PastGamesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastGamesNotifier = ref.read(pastGamesProvider.notifier);

    final pastGamesAsync = ref.watch(pastGamesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Past Games'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: pastGamesNotifier.fetchGames,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: GameStorageDatabaseHelper.instance.deleteAllGames,
          ),
        ],
      ),
      body: pastGamesAsync.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stack) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('An error occurred while fetching past games.'),
              TextButton.icon(
                onPressed: GameStorageDatabaseHelper.instance.deleteAllGames,
                icon: const Icon(Icons.delete),
                label: const Text('Delete all games'),
              ),
              Center(
                child: Text('Error fetching past games, please try again.'),
              ),
              Divider(),
              Wrap(
                direction: Axis.vertical,
                children: <Widget>[
                  FittedBox(child: Text('Error stack trace: $error')),
                  FittedBox(child: Text('Stack trace: $stack')),
                ],
              ),
            ],
          );
        },
        data: (List<PastGame> games) {
          if (games.isEmpty) {
            return const Center(child: Text('No past games available.'));
          }
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];

              final date =
                  game.currentPlay.timestamp.toLocal().toString().split(' ')[0];

              final playerScores = game.players
                  .map((player) => '${player.name}: ${player.score}')
                  .join(', ');

              return Container(
                padding: const EdgeInsets.all(8),
                color: Theme.of(context).listTileTheme.tileColor,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Game on $date'),
                      subtitle: Text(playerScores),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_rounded),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  PastGameScreen(gameId: game.id),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
