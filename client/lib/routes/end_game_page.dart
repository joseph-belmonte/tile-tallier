import 'package:flutter/material.dart';

import '../models/game.dart';
import 'home_page.dart';

class EndGamePage extends StatelessWidget {
  const EndGamePage({
    required this.winner,
    required this.rankedPlayers,
    required this.game,
    super.key,
  });

  final Game game;
  final Player winner;
  final List<Player> rankedPlayers;

  showStatsDialog(BuildContext context) {
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
                child: Text('Total Plays: ${game.plays.length}'),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Longest Word: ${game.longestWord}'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Highest Scoring Word: ${game.highestScoringWord.word} - ${game.highestScoringWord.score}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Highest Scoring Turn:'),
              ),
              ...game.highestScoringTurn.playedWords.map(
                (word) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text('${word.word} - ${word.score}'),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Shortest Word: ${game.shortestWord}'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GAME OVER'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Winner: ${winner.name} with a score of ${winner.score}!'),
              SizedBox(height: 20),
              Text('Rankings:'),
              SizedBox(height: 20),
              ...rankedPlayers
                  .map(
                    (player) => Text(
                      '${player.name}: ${player.score}',
                      style: TextStyle(
                        color: player == winner ? Colors.green : Colors.black,
                      ),
                    ),
                  )
                  .toList(),
              ElevatedButton.icon(
                onPressed: () => showStatsDialog(context),
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
