import 'package:flutter/material.dart';

import '../../../domain/models/game.dart';

class PlayerRankings extends StatelessWidget {
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
          (player) => Text(
            '${player.name}: ${player.score}',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ],
    );
  }
}
