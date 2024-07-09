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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Current: ${game.currentPlayer.name}'),
          Text('Play Score: ${game.currentPlay!.score}'),
          Text('Word Score: ${game.currentWord!.score}'),
          IconButton(
            onPressed: notifier.toggleBingo,
            icon: game.currentPlay!.isBingo
                ? Icon(Icons.star, semanticLabel: 'Play is bingo')
                : Icon(Icons.star_border, semanticLabel: 'Play is not bingo'),
            iconSize: 32.0,
          ),
          Text(
            'Played Words: ${game.currentPlay!.playedWords.map((word) => word.word).join(', ')}',
          ),
        ],
      ),
    );
  }
}
