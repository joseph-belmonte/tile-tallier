import 'package:flutter/material.dart';

import '../../../../core/domain/models/game_player.dart';
import '../../../../core/domain/models/play.dart';

import 'scrabble_word.dart';

/// A widget to display a historical play.
class HistoricalPlay extends StatelessWidget {
  /// The play to display.
  final Play play;

  /// Index of the play in the game.
  final int index;

  /// The player who made the play.
  final GamePlayer player;

  /// Creates a new [HistoricalPlay] instance.
  const HistoricalPlay(
    this.index, {
    required this.player,
    required this.play,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Turn: ${index + 1}'),
          Text('Player: ${player.name}'),
          Row(
            children: <Widget>[
              play.isBingo ? Icon(Icons.star) : Icon(Icons.star_border),
              const SizedBox(width: 8),
              Text('Score: ${play.score}'),
            ],
          ),
          for (var word in play.playedWords)
            Center(child: ScrabbleWordWidget(word, (value) {})),
          if (play.playedWords.isEmpty) Center(child: Text('Skipped')),
        ],
      ),
    );
  }
}
