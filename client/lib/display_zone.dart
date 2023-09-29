import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/game.dart';
import 'providers/active_game.dart';
import 'providers/active_play.dart';

class PlayerScoreCards extends StatelessWidget {
  final List<Player> players;
  static const List<Color> colors = [
    Color.fromARGB(255, 101, 160, 255),
    Color.fromARGB(255, 69, 222, 102),
    Color.fromARGB(255, 255, 234, 0),
    Color.fromARGB(255, 221, 150, 218),
  ];

  final bool displayScores;
  const PlayerScoreCards(this.players, {this.displayScores = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ActiveGame, Game>(
      selector: (_, activeGame) => activeGame.activeGame,
      builder: (BuildContext context, Game game, Widget? child) => Consumer<ActivePlay>(
        builder: (context, activePlay, child) {
          return Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < players.length; i++)
                  PlayerScoreCard(
                    player: players[i],
                    color: colors[i],
                    isActive: players[i] == game.currentPlayer,
                    displayScores: displayScores,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PlayerScoreCard extends StatelessWidget {
  final Player player;
  final Color color;
  final bool isActive;
  final bool displayScores;

  const PlayerScoreCard({
    required this.player,
    required this.color,
    required this.isActive,
    required this.displayScores,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(isActive ? Icons.person : Icons.person_outline, color: Colors.white),
            Text(player.name, style: Theme.of(context).textTheme.titleLarge),
            if (displayScores)
              Text(player.score.toString(), style: Theme.of(context).textTheme.bodyLarge)
            else
              Text(''),
            if (player.plays.isNotEmpty) MostRecentTurnDisplay(player),
          ],
        ),
      ),
    );
  }
}

class MostRecentTurnDisplay extends StatelessWidget {
  const MostRecentTurnDisplay(this.player, {super.key});

  final Player player;

  Play get lastTurn => player.plays.last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Last Turn ${lastTurn.isBingo ? '⭐️' : ''}',
            style: Theme.of(context).textTheme.titleSmall!,
            textAlign: TextAlign.center,
          ),
          if (lastTurn.playedWords.isNotEmpty)
            Text(
              lastTurn.playedWords.map((e) => '${e.word} - ${e.score}').join('\n'),
              style: Theme.of(context).textTheme.bodySmall!,
              textAlign: TextAlign.start,
            )
          else
            Text(
              'Skipped',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white70),
              textAlign: TextAlign.start,
            ),
        ],
      ),
    );
  }
}
