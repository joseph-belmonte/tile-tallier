import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/active_game.dart';

/// A widget to display the current turn information.
class TurnHUD extends ConsumerWidget {
  /// Creates a new [TurnHUD] instance.
  const TurnHUD({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(activeGameProvider);
    final notifier = ref.read(activeGameProvider.notifier);
    return Container(
      key: const Key('turn_hud'),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              game.currentPlayer.name,
              style: Theme.of(context).textTheme.headlineSmall!,
            ),
            if (game.currentPlay!.playedWords.isNotEmpty ||
                game.currentPlay!.isBingo)
              Text('Play Score: ${game.currentPlay!.score}'),
            Text(
              'Word Score: ${game.currentWord!.score}',
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
            IconButton(
              onPressed: notifier.toggleBingo,
              icon: game.currentPlay!.isBingo
                  ? Spin(
                      duration: Durations.long1,
                      key: const Key('bingo'),
                      child: Icon(Icons.star, semanticLabel: 'Play is bingo'),
                    )
                  : Icon(Icons.star_border, semanticLabel: 'Play is not bingo'),
              iconSize: 44.0,
            ),
            if (game.currentPlay?.playedWords.isNotEmpty ?? false) ...[
              const SizedBox(height: 8.0),
              Text(
                'Played Words:',
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
              Text(
                game.currentPlay!.playedWords
                    .map((word) => word.word)
                    .join(', '),
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
