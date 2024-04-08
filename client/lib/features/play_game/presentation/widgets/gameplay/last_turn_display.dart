import 'package:flutter/material.dart';

import '../../../domain/models/play.dart';
import '../../../domain/models/player.dart';

/// A widget to display the most recent turn for a player.
class MostRecentTurnDisplay extends StatelessWidget {
  /// Creates a new [MostRecentTurnDisplay] instance.
  const MostRecentTurnDisplay(this.player, {super.key});

  /// The player to display.
  final Player player;

  /// The last turn played by the player.
  Play get lastTurn => player.plays.last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Last Turn ${lastTurn.isBingo ? '⭐️' : ''}',
            style: Theme.of(context).textTheme.titleSmall!,
            textAlign: TextAlign.center,
          ),
          if (lastTurn.playedWords.isNotEmpty)
            Text(
              lastTurn.playedWords.map((e) => '${e.word} - ${e.score}').join('\n'),
              style: Theme.of(context).textTheme.bodySmall!,
              textAlign: TextAlign.start,
            )
          else
            Text(
              'Skipped',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white70),
              textAlign: TextAlign.start,
            ),
        ],
      ),
    );
  }
}
