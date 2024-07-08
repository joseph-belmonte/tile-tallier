import 'package:flutter/material.dart';

import '../../../core/domain/models/game.dart';
import '../widgets/home_button.dart';
import '../widgets/results/player_rankings.dart';
import '../widgets/results/show_stats_button.dart';
import '../widgets/results/winner_header.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('GAME OVER'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WinnerHeader(game: _game),
              SizedBox(height: 20),
              PlayerRankings(game: _game),
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
