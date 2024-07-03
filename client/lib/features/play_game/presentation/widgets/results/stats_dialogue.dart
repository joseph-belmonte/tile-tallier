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
        'Notable Stats',
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Total Plays: ${_game.plays.length}',
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Longest Word: ${_game.longestWord}, for ${_game.longestWord.length} letters',
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Highest Scoring Word:\n${_game.highestScoringWord.word} - ${_game.highestScoringWord.score}',
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text('Highest Scoring Turn:'),
            ),
            if (topPlay != null)
              if (topPlay.isBingo)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Bingo! +50 points',
                  ),
                ),
            if (topPlay != null)
              ...topPlay.playedWords.map(
                (word) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    '${word.word} - ${word.score}',
                  ),
                ),
              ),
            if (topPlay != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Total: ${topPlay.score}',
                ),
              ),
            if (topPlay != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Score multipliers: ${topPlay.playedWords.map((word) => word.playedLetters.map((letter) => letter.scoreMultiplier.name).where((name) => name != 'none').join(', ')).join(', ')}',
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Close',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
