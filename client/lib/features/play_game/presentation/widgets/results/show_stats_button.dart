import 'package:flutter/material.dart';

import '../../../../core/domain/models/game.dart';
import 'stats_dialogue.dart';

/// Shows the stats for the game. If the game was empty, displays a snackbar.
class StatsButton extends StatelessWidget {
  /// The game to show the stats for.
  final Game game;

  /// Creates a new [StatsButton] instance.
  const StatsButton({
    required this.game,
    super.key,
  });

  Future<void> _showStatsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => StatsDialog(game: game),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (game.plays.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.error,
              content: Text(
                'No plays were made in this game.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onError,
                    ),
              ),
            ),
          );
          return;
        } else {
          _showStatsDialog(context);
        }
      },
      icon: Icon(
        Icons.format_list_numbered,
        color: Theme.of(context).colorScheme.primary,
      ),
      label: Text(
        'Stats',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
