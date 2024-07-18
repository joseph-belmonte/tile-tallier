import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../utils/share_utils.dart';
import '../../../../utils/toast.dart';
import '../../../play_game/presentation/screens/player_results.dart';
import '../../../play_game/presentation/widgets/gameplay/historical_play.dart';
import '../../../play_game/presentation/widgets/results/shareable.dart';
import '../../application/providers/past_games_provider.dart';
import '../controllers/history_page_controller.dart';

/// A page that displays a past game.
class PastGamePage extends ConsumerWidget {
  /// The [Game] whose details are displayed.
  final String gameId;

  /// Creates a new [PastGamePage] instance.
  PastGamePage({required this.gameId, super.key});

  final GlobalKey _shareKey = GlobalKey();

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

    void handleShare() async {
      final imageBytes = await capturePng(_shareKey);
      final imageFile = await saveImage(imageBytes);
      final xFile = getXFile(imageFile);

      // ignore: unused_local_variable
      var platform = '';
      var shareText = '';
      if (Platform.isIOS) {
        platform = 'iOS';
      } else if (Platform.isAndroid) {
        platform = 'Android';
      }

      shareText = 'Score with me next time: bit.ly';
      // TODO: fix the subject line on share to just be the link to the app
      // right now it says "1 file and document"
      // - remove the widget from the visible pastgame page
      // - shareable widget shouldn't even be visible; it should be a hidden widget
      // and should only be copied to the clipboard when the share button is pressed
      // - add the share button to the appbar for the immediate results page

      await Share.shareXFiles(
        [xFile],
        text: shareText,
        subject: 'TileTallier',
      );

      // Delete the image file
      await imageFile.delete();
    }

    void handleFavorite() {
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
        title: Text(date),
        actions: <Widget>[
          IconButton(
            onPressed: handleShare,
            icon: Icon(Icons.share),
          ),
          IconButton(
            icon: Icon(
              game.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: handleFavorite,
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
            RepaintBoundary(
              key: _shareKey,
              child: Shareable(game: game),
            ),
          ],
        ),
      ),
    );
  }
}
