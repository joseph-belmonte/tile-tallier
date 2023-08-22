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
    // TODO: make this a property on the Player class
    final Map<Player, int> playerTurnCounts = {};

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: player.plays.length,
                          itemBuilder: (context, index) {
                            var currentTurn = player.plays[index];
                            // Retrieve the turn count for the current player
                            final turnCount = playerTurnCounts[player] ?? 0;
                            playerTurnCounts[player] = turnCount + 1;
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (var playedWord in currentTurn.playedWords)
                                  if (playedWord ==
                                      currentTurn.playedWords.first)
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                    )
                                  else
                                    Container(),
                                // display each word, and its individual score
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
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
