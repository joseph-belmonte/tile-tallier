import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/theming.dart';
import '../../application/providers/active_game.dart';

import 'player_score_card.dart';

/// A widget to display the score cards for the players.
class PlayerScoreCards extends ConsumerWidget {
  /// Creates a new [PlayerScoreCards] instance.
  const PlayerScoreCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(activeGameProvider);

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: game.players.length,
        itemBuilder: (_, int index) {
          return PlayerScoreCard(
            key: ValueKey(game.players[index].id),
            player: game.players[index],
            color: playercolors[index % playercolors.length],
            isActive: game.players[index] == game.currentPlayer,
          );
        },
      ),
    );
  }
}
