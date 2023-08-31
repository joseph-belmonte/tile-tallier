import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_state.dart';
import 'models/game_state.dart';

class DisplayZone extends StatelessWidget {
  const DisplayZone({super.key});

  @override
  Widget build(BuildContext context) {
    var players = Provider.of<CurrentGameState>(context).gameState.players;

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
                      PlayerNameDisplay(player: player),
                      PlayerScoreDisplay(player: player),
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
              'Turn ${turnIndex + 1}: ',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium,
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

class PlayerScoreDisplay extends StatelessWidget {
  const PlayerScoreDisplay({
    required this.player,
    super.key,
  });

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${player.score}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class PlayerNameDisplay extends StatelessWidget {
  const PlayerNameDisplay({
    required this.player,
    super.key,
  });

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${player.name}: ',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
