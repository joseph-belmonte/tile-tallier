import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';
import '../providers/active_game.dart';
import '../providers/active_play.dart';


class PlayerScoreCards extends StatelessWidget {
  static const List<Color> playerColors = [
    Color.fromARGB(255, 101, 160, 255),
    Color.fromARGB(255, 69, 222, 102),
    Color.fromARGB(255, 255, 234, 0),
    Color.fromARGB(255, 221, 150, 218),
  ];
  final List<Player> players;
  const PlayerScoreCards(this.players, {super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ActiveGame, Game>(
      selector: (_, activeGame) => activeGame.activeGame,
      builder: (context, activeGame, __) => _buildWidget(activeGame),
    );
  }

  Widget _buildWidget(Game activeGame) {
    return Consumer<ActivePlay>(
      builder: (_, activePlay, ___) => _build(activePlay.play!.player),
    );
  }

  Widget _build(Player activePlayer) {
    List<Widget> scoreCards = [];

    for (int i = 0; i < players.length; i++) {
      scoreCards.add(
        PlayerScoreCard(
          player: players[i],
          color: playerColors[i],
          isActive: players[i] == activePlayer,
        ),
      );
    }
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: scoreCards,
      ),
    );
  }
}

class PlayerScoreCard extends StatelessWidget {
  final Player player;
  final Color color;
  final bool isActive;

  const PlayerScoreCard({
    required this.player,
    required this.color,
    required this.isActive,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Icon(isActive ? Icons.person : Icons.person_outline, color: Colors.white),
      Text(player.name, style: Theme.of(context).textTheme.titleLarge),
      Text(player.score.toString(), style: Theme.of(context).textTheme.bodyLarge),
    ];

    if (player.plays.isNotEmpty) {
      children.add(MostRecentTurnDisplay(player));
    }
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
          children: children,
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
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last Turn ${lastTurn.isBingo ? '⭐️' : ''}',
            style: textTheme.titleSmall!,
            textAlign: TextAlign.center,
          ),
          Text(
            lastTurn.playedWords.map((e) => '${e.word} - ${e.score}').join('\n'),
            style: textTheme.bodySmall!,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
