import 'package:flutter/material.dart';

import '../../../domain/models/game.dart';

import '../home.dart';

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
      builder: (context) => AlertDialog(
        title: Text('Game Statistics'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Total Plays: ${_game.plays.length}'),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Longest Word: ${_game.longestWord}'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Highest Scoring Word: ${_game.highestScoringWord.word} - ${_game.highestScoringWord.score}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Highest Scoring Turn:'),
              ),
              if (_game.highestScoringPlay != null)
                ..._game.highestScoringPlay!.playedWords.map(
                  (word) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('${word.word} - ${word.score}'),
                  ),
                ),
              Divider(),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GAME OVER'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'Winner: ${_game.sortedPlayers[0].name} with a score of ${_game.sortedPlayers[0].score}!',
              ),

              SizedBox(height: 20),
              Text('Rankings:'),
              SizedBox(height: 20),
              ..._game.sortedPlayers
                  .map(
                    (player) => Text(
                      '${player.name}: ${player.score}',
                      style: TextStyle(
                        color: player == _game.sortedPlayers[0] ? Colors.green : Colors.black,
                      ),
                    ),
                  )
                  .toList(),
              ElevatedButton.icon(
                onPressed: () => _showStatsDialog(context),
                icon: Icon(Icons.format_list_numbered),
                label: Text('Stats'),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                ),
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
