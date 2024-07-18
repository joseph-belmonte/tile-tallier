import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/toast.dart';
import '../../../play_game/presentation/screens/player_results.dart';
import '../../../play_game/presentation/widgets/gameplay/historical_play.dart';
import '../../../shared/presentation/widgets/share_modal.dart';
import '../../application/providers/past_games_provider.dart';
import '../controllers/history_page_controller.dart';

/// A page that displays a past game.
class PastGamePage extends ConsumerWidget {
  /// The [Game] whose details are displayed.
  final String gameId;

  /// Creates a new [PastGamePage] instance.
  const PastGamePage({required this.gameId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const animationDuration = Durations.medium1;
    final pastGamesState = ref.watch(pastGamesProvider);

    final game = pastGamesState.firstWhere((g) => g.id == gameId);
    final date = game.plays.first.timestamp.toLocal().toString().split(' ')[0];

    void toggleFavorite() async {
      await ref
          .read(historyPageControllerProvider.notifier)
          .toggleFavorite(game.id);
    }

    void handleFavorite() {
      toggleFavorite();
      if (!game.isFavorite) {
        ToastService.message(context, 'Game added to favorites');
      } else {
        ToastService.message(context, 'Game removed from favorites');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(date),
        actions: <Widget>[
          IconButton(
            onPressed: () => showShareModal(context, game),
            icon: Icon(Icons.share),
          ),
          game.isFavorite
              ? FadeInDown(
                  duration: animationDuration,
                  from: 10.0,
                  child: IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: handleFavorite,
                  ),
                )
              : FadeInUp(
                  duration: animationDuration,
                  from: 10.0,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: handleFavorite,
                  ),
                ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Players: ${game.players.map((p) => p.name).join(', ')}'),
            Text(
              'Winner: ${game.sortedPlayers.first.name} - ${game.sortedPlayers.first.score}',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: game.plays.length,
                itemBuilder: (_, int i) {
                  final play = game.plays[i];
                  final player = game.players.firstWhere(
                    (player) => player.id == play.playerId,
                  );

                  final animationDuration = game.plays.length == 1
                      ? Durations.medium4
                      : Durations.extralong1 ~/ (game.plays.length - i);

                  return FadeInUp(
                    duration: animationDuration,
                    child: HistoricalPlay(
                      key: ValueKey(play.id),
                      player: player,
                      play: play,
                      i,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            Divider(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // End Racks:
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
                    // Final Scores:
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
