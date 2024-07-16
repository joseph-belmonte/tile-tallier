import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/toast.dart';
import '../../../play_game/presentation/screens/player_results.dart';
import '../../../play_game/presentation/widgets/gameplay/historical_play.dart';
import '../../application/providers/past_games_provider.dart';
import '../controllers/history_page_controller.dart';

/// A page that displays a past game.
class PastGameScreen extends ConsumerWidget {
  /// The [Game] whose details are displayed.
  final String gameId;

  /// Creates a new [PastGameScreen] instance.
  const PastGameScreen({required this.gameId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastGamesState = ref.watch(pastGamesProvider);

    final game = pastGamesState.firstWhere((g) => g.id == gameId);
    final date = game.plays.first.timestamp.toLocal().toString().split(' ')[0];

    void toggleFavorite() async {
      await ref
          .read(historyPageControllerProvider.notifier)
          .toggleFavorite(game.id);
    }

    void handleFavoriteButtonPressed() {
      toggleFavorite();
      if (!game.isFavorite) {
        ToastService.message(context, 'Game added to favorites');
      } else {
        ToastService.message(
          context,
          'Game removed from favorites',
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Game on $date'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              game.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: handleFavoriteButtonPressed,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: game.plays.length,
                itemBuilder: (_, int i) {
                  final play = game.plays[i];
                  final player = game.players.firstWhere(
                    (player) => player.id == play.playerId,
                  );

                  return HistoricalPlay(
                    key: ValueKey(play.id),
                    player: player,
                    play: play,
                    i,
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            Divider(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('End Racks:'),
                    ...game.players.map((player) {
                      return Text(
                        '${player.name}: ${player.endRack.isEmpty ? 'Empty' : player.endRack}',
                      );
                    }),
                  ],
                ),
                SizedBox(width: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('Final Scores:'),
                        ...game.sortedPlayers.map((player) {
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PlayerResultsScreen(
                                  game: game,
                                  player: player,
                                ),
                              ),
                            ),
                            child: Text(
                              '${player.name}: ${player.score}',
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
                // Final Scores:
              ],
            ),
            // End Racks:
          ],
        ),
      ),
    );
  }
}
