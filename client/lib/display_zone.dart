import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'active_game.dart';
import 'models/game.dart';
import 'routes/end_game_page.dart';

class DisplayZone extends StatelessWidget {
  const DisplayZone({super.key});

  @override
  Widget build(BuildContext context) {
    var activeGame = Provider.of<ActiveGame>(context, listen: true).activeGame;

    /// Calculates the winner and navigates to the end game page.
    void onEndGame() {
      // first, call the getWinner method to determine the winner
      final winner = activeGame.getWinner();
      final playerPositions = activeGame.getSortedPlayers();
      // then, navigate to the end game page
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EndGamePage(
            winner: winner,
            rankedPlayers: playerPositions,
            game: activeGame,
          ),
        ),
      );
    }

    var players = activeGame.players;

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () => onEndGame(),
                icon: Icon(Icons.assistant_photo_rounded),
                label: Text('End Game'),
              ),
              for (var player in players)
                Container(
                  height: 80,
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
                      PlayerHeading(player: player),
                      Expanded(
                        child: ListView.builder(
                          key: ValueKey(player.name),
                          shrinkWrap: true,
                          itemCount: player.plays.length,
                          itemBuilder: (context, index) {
                            return TurnSummary(
                              player: player,
                              turnIndex: index,
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

class TurnSummary extends StatelessWidget {
  const TurnSummary({
    required this.player,
    required this.turnIndex,
    super.key,
  });

  final Player player;
  final int turnIndex;

  @override
  Widget build(BuildContext context) {
    var currentTurn = player.plays[turnIndex];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${currentTurn.isBingo ? '⭐' : ''} Turn ${turnIndex + 1}: ',
              textAlign: TextAlign.left,
              style: TextStyle(
                decoration: turnIndex == player.plays.length - 1 &&
                        Provider.of<ActiveGame>(context)
                                .activeGame
                                .activePlayer ==
                            player
                    ? TextDecoration.underline
                    : TextDecoration.none,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              currentTurn.score.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Text(
          currentTurn.playedWords
              .map((e) => '${e.word} - ${e.score}')
              .join('\n'),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class PlayerHeading extends StatelessWidget {
  const PlayerHeading({
    required this.player,
    super.key,
  });

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              '${player.name}: ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        SizedBox(width: 10),
        Column(
          children: [
            Text(
              '${player.score}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
