import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';

import 'models/game_state.dart';

class DisplayZone extends StatelessWidget {
  const DisplayZone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notifier = Provider.of<GameStateNotifier>(context);
    var players = notifier.gameState.players;

    // Create a map to track the turn count for each player
    final Map<Player, int> playerTurnCounts = {};

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var player in players)
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  margin: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${player.name}: ${player.score}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: player.plays.length,
                          itemBuilder: (context, index) {
                            var currentTurn = player.plays[index];
                            // Retrieve the turn count for the current player
                            final turnCount = playerTurnCounts[player] ?? 0;
                            playerTurnCounts[player] = turnCount + 1;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Turn ${turnCount + 1}: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      currentTurn.score.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  currentTurn.playedWords
                                      .map((e) => '${e.word} - ${e.score}')
                                      .join('\n'),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
