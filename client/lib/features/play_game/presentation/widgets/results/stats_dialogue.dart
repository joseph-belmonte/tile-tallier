import 'package:flutter/material.dart';

import '../../../domain/models/game.dart';

/// A stateless widget that displays the game statistics.
class StatsDialog extends StatelessWidget {
  /// Creates a new [StatsDialog] instance.
  const StatsDialog({
    required Game game,
    super.key,
  }) : _game = game;

  final Game _game;

  @override
  Widget build(BuildContext context) {
    final topPlay = _game.highestScoringPlay;
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      title: Text(
        'Game Summary',
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
      content: SingleChildScrollView(
        primary: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Winner: ${_game.sortedPlayers.first.name}'),
            Text('Total Plays: ${_game.plays.length}'),
            SizedBox(height: 16),
            Text('Longest Word:'),
            Text(_game.longestWord),
            SizedBox(height: 16),
            Text('Highest Scoring Word:'),
            Text(
              '${_game.highestScoringWord.word} - ${_game.highestScoringWord.score}',
            ),
            SizedBox(height: 16),
            Text('Highest Scoring Play:'),
            if (topPlay != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Player: ${_game.players.where((player) => player.id == topPlay.playerId).first.name}',
                  ),
                  Text(
                    'Play Score: ${topPlay.score} ${topPlay.isBingo ? '- Bingo!' : ''}',
                  ),
                  SizedBox(height: 8),
                  Text('Played Words:'),
                  ...topPlay.playedWords.map(
                    (word) => Text('${word.word} - ${word.score}'),
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Close',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
