import 'package:flutter/material.dart';

import '../../../domain/models/game.dart';

/// A header that displays the winner of the game.
class WinnerHeader extends StatelessWidget {
  /// Creates a new [WinnerHeader] instance.
  const WinnerHeader({
    required Game game,
    super.key,
  }) : _game = game;

  final Game _game;

  @override
  Widget build(BuildContext context) {
    final isDraw = _game.sortedPlayers[0].score == _game.sortedPlayers[1].score;

    return Column(
      children: <Widget>[
        if (isDraw)
          Text(
            'It\'s a draw!',
            style: TextStyle(color: Colors.red),
          ),
        if (isDraw)
          Text(
            '${_game.sortedPlayers[0].name} and ${_game.sortedPlayers[1].name} tied with a score of ${_game.sortedPlayers[0].score}!',
          ),
        if (!isDraw)
          Text(
            'Winner: ${_game.sortedPlayers[0].name} with a score of ${_game.sortedPlayers[0].score}!',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
      ],
    );
  }
}
