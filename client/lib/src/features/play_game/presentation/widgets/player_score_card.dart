import 'package:flutter/material.dart';

import '../../domain/models/player.dart';
import 'last_turn_display.dart';

/// A widget that displays a player's score card.
class PlayerScoreCard extends StatelessWidget {
  /// The player to display.
  final Player player;

  /// The color to use for the card.
  final Color color;

  /// Whether the player is active.
  final bool isActive;

  /// Creates a new [PlayerScoreCard] instance.
  const PlayerScoreCard({
    required this.player,
    required this.color,
    required this.isActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(isActive ? Icons.person : Icons.person_outline, color: Colors.white),
            Text(player.name, style: Theme.of(context).textTheme.titleLarge),
            // read from the provider
            // if (displayScores)
            Text(player.score.toString(), style: Theme.of(context).textTheme.bodyLarge),
            // else
            //   Text(''),
            if (player.plays.isNotEmpty) MostRecentTurnDisplay(player),
          ],
        ),
      ),
    );
  }
}
