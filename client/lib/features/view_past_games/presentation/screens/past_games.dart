import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/logger.dart';
import '../../../core/domain/models/game.dart';
import '../../application/providers/past_games_provider.dart';
import '../widgets/deletion_dialog.dart';
import 'past_game.dart';

/// A page that displays the past games.
class PastGamesPage extends ConsumerStatefulWidget {
  /// Creates a new [PastGamesPage] instance.
  const PastGamesPage({super.key});

  @override
  ConsumerState<PastGamesPage> createState() => _PastGamesPageState();
}

class _PastGamesPageState extends ConsumerState<PastGamesPage> {
  @override
  void initState() {
    super.initState();
    // Fetch games when the widget is first built
    Future.microtask(() => ref.read(pastGamesProvider.notifier).fetchGames());
  }

  @override
  Widget build(BuildContext context) {
    final pastGamesAsync = ref.watch(pastGamesProvider);

    /// Deletes all games from the database and updates the state.
    void deletePastGames() async {
      await ref.read(pastGamesProvider.notifier).deleteAllGames();
      ref.read(pastGamesProvider.notifier).fetchGames();
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Past Games'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              logger.d('showing modal');
              showDeletionDialog(
                context,
                onConfirm: deletePastGames,
              );
            },
          ),
        ],
      ),
      body: pastGamesAsync.when(
        skipLoadingOnRefresh: true,
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
                onPressed: () async {
                  await ref.read(pastGamesProvider.notifier).deleteAllGames();
                  ref.read(pastGamesProvider.notifier).fetchGames();
                },
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
                  Wrap(
                    children: <Widget>[
                      const Text('Stack trace: '),
                      Text('$stack'),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
        data: (List<Game> games) {
          if (games.isEmpty) {
            return const Center(child: Text('No past games available.'));
          }
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              final playCount = game.plays.length;

              if (playCount == 0) {
                return const Text('No plays in this game');
              }

              final date = game.plays[playCount - 1].timestamp
                  .toLocal()
                  .toString()
                  .split(' ')[0];

              final playerScores = game.players
                  .map((player) => '${player.name}: ${player.score}')
                  .join(', ');

              return Dismissible(
                key: Key(game.id),
                onDismissed: (direction) {
                  ref.read(pastGamesProvider.notifier).deleteGame(game.id);
                },
                direction: DismissDirection.endToStart,
                background: Container(color: Colors.red),
                child: Container(
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
