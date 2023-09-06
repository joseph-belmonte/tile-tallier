import 'package:flutter/material.dart';

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
    String shortestWord = rankedPlayers[0].shortestWord;
    String longestWord = rankedPlayers[0].longestWord;
    PlayedWord highestScoringWord = rankedPlayers[0].highestScoringWord;
    Play highestScoringTurn = rankedPlayers[0].highestScoringTurn;

    for (final player in rankedPlayers) {
      if (player.longestWord.length > longestWord.length) {
        longestWord = player.longestWord;
      }
      if (player.highestScoringWord.score > highestScoringWord.score) {
        highestScoringWord = player.highestScoringWord;
      }
      if (player.highestScoringTurn.score > highestScoringTurn.score) {
        highestScoringTurn = player.highestScoringTurn;
      }
      if (player.shortestWord.length < shortestWord.length) {
        shortestWord = player.shortestWord;
      }
    }

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
                Text('Longest Word: $longestWord'),
                SizedBox(height: 20),
                Text('Highest Scoring Word: ${highestScoringWord.word}'),
                SizedBox(height: 20),
                Text(
                  'Highest Scoring Turn: ${highestScoringTurn.score} - ${highestScoringTurn.playedWords.map((word) => word.word)}',
                ),
                SizedBox(height: 20),
                Text('Shortest Word: $shortestWord'),
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
                // display a pop up with some stats
                onPressed: () => showStatsDialog(context),
                icon: Icon(Icons.format_list_numbered),
                label: Text('Stats'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
