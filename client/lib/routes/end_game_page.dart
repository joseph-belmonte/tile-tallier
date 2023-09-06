import 'package:flutter/material.dart';

import '../models/game.dart';

class EndGamePage extends StatelessWidget {
  const EndGamePage({
    required this.winner,
    required this.rankedPlayers,
    super.key,
  });

  final Player winner;
  final List<Player> rankedPlayers;

  showStatsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Statistics'),
        content: Text('This is where the stats will go'),
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
