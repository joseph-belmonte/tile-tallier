import 'package:flutter/material.dart';

import '../../domain/models/game.dart';
import '../widgets/home_button.dart';
import '../widgets/results/results_bar_chart.dart';
import '../widgets/results/show_stats_button.dart';

/// A page that displays the game statistics and the winner of the game.
class ResultsPage extends StatelessWidget {
  /// Creates a new [ResultsPage] instance.
  const ResultsPage({
    required Game game,
    super.key,
  }) : _game = game;

  final Game _game;

  @override
  Widget build(BuildContext context) {
    final isDraw = _game.sortedPlayers[0].score == _game.sortedPlayers[1].score;
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
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              SizedBox(height: 20),
              Text(
                'Rankings:',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              SizedBox(height: 24),
              ..._game.sortedPlayers.map(
                (player) => Text(
                  '${player.name}: ${player.score}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              Center(child: ResultsBarChart()),
              SizedBox(height: 36),
              StatsButton(game: _game),
              SizedBox(height: 12),
              HomeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
