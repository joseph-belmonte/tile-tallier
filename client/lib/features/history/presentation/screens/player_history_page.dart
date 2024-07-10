import 'package:flutter/material.dart';

import '../../domain/models/player.dart';

/// A page that displays a list of all games that a player has played.
/// Perhaps put some personal stats here in the future.
/// Ex: Win rate, average score, average rank, etc.
/// should have a button to edit the player name
class PlayerHistoryPage extends StatelessWidget {
  /// The [Player] whose history is displayed.
  final Player player;

  /// Creates a new [PlayerHistoryPage] instance.
  const PlayerHistoryPage({required this.player, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${player.name} History'),
      ),
      body: Center(
        child: Placeholder(),
      ),
    );
  }
}
