import 'package:flutter/material.dart';
import 'package:scrabble_scorer/routes/home_page.dart';

import '../models/game.dart';

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
        content: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text('Total Plays: ${game.plays.length}'),
                SizedBox(height: 20),
                Text('Longest Word: ${game.longestWord}'),
                SizedBox(height: 20),
                Text(
                  'Highest Scoring Word: ${game.highestScoringWord.word} - ${game.highestScoringWord.score}',
                ),
                SizedBox(height: 20),
                Text('Highest Scoring Turn:'),
                SizedBox(height: 20),
                Text('Score: ${game.highestScoringTurn.score}'),
                SizedBox(height: 20),
                ...game.highestScoringTurn.playedWords.map(
                  (word) => Text(
                    '${word.word} ',
                  ),
                ),
                SizedBox(height: 20),
                Text('Shortest Word: ${game.shortestWord}'),
              ],
            ),
          ),
        ),
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
