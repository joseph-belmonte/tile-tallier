import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../display_zone.dart';
import '../models/game.dart';
import '../providers/active_game.dart';
import '../writing_zone.dart';

import 'end_game_page.dart';

class PlayInputPage extends StatelessWidget {
  static const endGameButton = EndGameButton();
  static const writingZone = WritingZone();
  const PlayInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ActiveGame, List<Player>>(
      selector: (_, activeGame) => activeGame.players,
      builder: (_, players, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [endGameButton, PlayerScoreCards(players), writingZone],
        );
      },
    );
  }
}

class EndGameButton extends StatelessWidget {
  const EndGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ActiveGame, Game>(
      selector: (context, activeGame) => activeGame.activeGame,
      builder: (context, activeGame, __) {
        return ElevatedButton.icon(
          label: Text('End Game'),
          icon: Icon(Icons.assistant_photo_rounded),

          /// Calculates the winner and navigates to the end game page.
          onPressed: () {
            final winner = activeGame.leader;
            final playerPositions = activeGame.getPlayersSortedByScore();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => EndGamePage(
                  winner: winner,
                  rankedPlayers: playerPositions,
                  game: activeGame,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
