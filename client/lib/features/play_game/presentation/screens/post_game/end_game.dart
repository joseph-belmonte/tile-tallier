import 'package:flutter/material.dart';

import '../../../../shared/presentation/screens/home.dart';
import '../../../domain/models/game.dart';
import '../../widgets/stats_dialogue.dart';

/// A page that displays the game statistics and the winner of the game.
class EndGamePage extends StatelessWidget {
  /// Creates a new [EndGamePage] instance.
  const EndGamePage({
    required Game game,
    super.key,
  }) : _game = game;

  final Game _game;

  Future<void> _showStatsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => StatsDialog(game: _game),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDraw = _game.sortedPlayers.length > 1 &&
        _game.sortedPlayers[0].score == _game.sortedPlayers[1].score;
    return Scaffold(
      appBar: AppBar(
        title: Text('GAME OVER'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (isDraw)
                Text(
                  'It\'s a draw!',
                  style: TextStyle(color: Colors.red),
                ),
              if (isDraw)
                Text(
                  '${_game.sortedPlayers[0].name} and ${_game.sortedPlayers[1].name} tied with a score of ${_game.sortedPlayers[0].score}!',
                ),
              if (!isDraw)
                Text(
                  'Winner: ${_game.sortedPlayers[0].name} with a score of ${_game.sortedPlayers[0].score}!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              SizedBox(height: 20),
              Text(
                'Rankings:',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              SizedBox(height: 24),
              ..._game.sortedPlayers.map(
                (player) => Text(
                  '${player.name}: ${player.score}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
              SizedBox(height: 36),
              ElevatedButton.icon(
                onPressed: () {
                  if (_game.plays.isEmpty) {
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
              ),
              SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                ),
                icon: Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: Text(
                  'Home',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
