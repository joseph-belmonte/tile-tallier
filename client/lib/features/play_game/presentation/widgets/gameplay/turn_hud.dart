import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/active_game.dart';

/// A widget to display the current turn information.
class TurnHUD extends ConsumerWidget {
  /// Creates a new [TurnHUD] instance.
  const TurnHUD({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const starSpins = 0.6;
    const animationDuration = Durations.long4;

    void handleFavorite() {
      ref.read(activeGameProvider.notifier).toggleBingo();
    }

    final game = ref.watch(activeGameProvider);
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
            Text('Word Score: ${game.currentWord!.score}'),
            IconButton(
              onPressed: handleFavorite,
              icon: ref.watch(activeGameProvider).currentPlay!.isBingo
                  ? Spin(
                      duration: animationDuration,
                      spins: starSpins,
                      key: const Key('bingo'),
                      child: Icon(Icons.star, semanticLabel: 'Play is bingo'),
                    )
                  : Spin(
                      duration: animationDuration,
                      spins: -starSpins,
                      key: const Key('no_bingo'),
                      child: Icon(
                        Icons.star_border,
                        semanticLabel: 'Play is not bingo',
                      ),
                    ),
              iconSize: 44.0,
            ),
            if (game.currentPlay?.playedWords.isNotEmpty ?? false) ...<Widget>[
              const SizedBox(height: 8.0),
              Text('Played Words:'),
              Text(
                game.currentPlay!.playedWords
                    .map((word) => word.word)
                    .join(', '),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
