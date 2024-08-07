import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/presentation/widgets/loading_spinner.dart';
import '../../../application/providers/active_game.dart';

/// A widget to display the current turn information:
/// - The current player's name
/// - The current word's score
/// - The current play's score (if it's a bingo)
class TurnHUD extends ConsumerWidget {
  /// Creates a new [TurnHUD] instance.
  const TurnHUD({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const starSpins = 0.6;
    const animationDuration = Durations.long1;

    void handleFavorite() {
      ref.read(activeGameProvider.notifier).toggleBingo();
    }

    final game = ref.watch(activeGameProvider);
    return game.players.isEmpty
        ? LoadingSpinner()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              key: const Key('turn_hud'),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      game.currentPlayer.name,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    Visibility.maintain(
                      visible: game.currentPlay!.playedWords.isNotEmpty ||
                          game.currentPlay!.isBingo,
                      child: Text('Play Score: ${game.currentPlay!.score}'),
                    ),
                    Text('Word Score: ${game.currentWord!.score}'),
                    IconButton(
                      onPressed: handleFavorite,
                      icon: ref.watch(activeGameProvider).currentPlay!.isBingo
                          ? Spin(
                              duration: animationDuration,
                              spins: starSpins,
                              key: const Key('bingo'),
                              child: Icon(
                                Icons.star,
                                semanticLabel: 'Play is bingo',
                              ),
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
                  ],
                ),
              ),
            ),
          );
  }
}
