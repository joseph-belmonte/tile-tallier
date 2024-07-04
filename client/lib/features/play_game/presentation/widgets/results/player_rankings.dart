import 'package:flutter/material.dart';

import '../../../domain/models/game.dart';
import '../../screens/player_results.dart';

/// A widget that displays the player rankings for a game.
class PlayerRankings extends StatelessWidget {
  /// Creates a new [PlayerRankings] instance.
  const PlayerRankings({
    required Game game,
    super.key,
  }) : _game = game;

  final Game _game;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Rankings:',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        SizedBox(height: 24),
        ..._game.sortedPlayers.map(
          (player) => TextButton(
            onPressed: () {
              // Navigate to player results for this player
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PlayerResultsScreen(
                      game: _game,
                      player: player,
                    );
                  },
                ),
              );
            },
            child: Text(
              '${player.name}: ${player.score}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
