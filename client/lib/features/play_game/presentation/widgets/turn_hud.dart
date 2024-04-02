import 'package:flutter/material.dart';

import '../../application/providers/active_game.dart';
import '../../domain/models/game.dart';

/// A widget to display the current turn information.
class TurnHUD extends StatelessWidget {
  /// Creates a new [TurnHUD] instance.
  const TurnHUD({
    required this.game,
    required this.gameNotifier,
    super.key,
  });

  /// The game to display the turn information for.
  final Game game;

  /// The notifier for the game, used to interact with the game.
  final ActiveGameNotifier gameNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Current: ${game.currentPlayer.name}'),
          Text('Play Score: ${game.currentPlay.score}'),
          Text('Word Score: ${game.currentWord.score}'),
          IconButton(
            onPressed: gameNotifier.toggleBingo,
            icon: game.currentPlay.isBingo ? Icon(Icons.star) : Icon(Icons.star_border),
            iconSize: 32.0,
          ),
          Text(
            'Played Words: ${game.currentPlay.playedWords.map((word) => word.word).join(', ')}',
          ),
        ],
      ),
    );
  }
}
