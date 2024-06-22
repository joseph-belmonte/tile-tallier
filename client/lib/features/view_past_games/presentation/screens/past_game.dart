import 'package:flutter/material.dart';

import '../../../play_game/domain/models/game.dart';
import '../../../play_game/presentation/widgets/gameplay/historical_play.dart';

/// A page that displays a past game.
class PastGame extends StatelessWidget {
  /// The [Game] whose details are displayed.
  final Game game;

  /// Creates a new [PastGame] instance.
  const PastGame({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    final date = game.plays.first.timestamp.toLocal().toString().split(' ')[0];

    return Scaffold(
      appBar: AppBar(
        title: Text('Game on $date'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () => print('Favorite/unfavorite game'),
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
            // EndRacks:
            Text('End Racks:'),
            Column(
              children: game.players.map((player) {
                return Text(
                  '${player.name}: ${player.endRack.isEmpty ? 'Empty' : player.endRack}',
                );
              }).toList(),
            ),
            // Final Scores:
            Text('Final Scores:'),
            Column(
              children: game.players.map((player) {
                return Text('${player.name}: ${player.score}');
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}