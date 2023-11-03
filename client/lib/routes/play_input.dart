import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';
import '../providers/active_game.dart';
import '../widgets/display_zone.dart';
import '../widgets/writing_zone.dart';
import 'game_end/subtract.dart';

class PlayInputPage extends StatelessWidget {
  static const endGameButton = EndGameButton();
  static const writingZone = WritingZone();
  const PlayInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PLAY INPUT'),
        automaticallyImplyLeading: false,
      ),
      body: Selector<ActiveGame, List<Player>>(
        selector: (_, activeGame) => activeGame.players,
        builder: (_, players, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              endGameButton,
              PlayerScoreCards(players),
              writingZone,
            ],
          );
        },
      ),
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
          icon: Icon(Icons.file_download_off_rounded),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SubtractPage(game: activeGame)),
            );
          },
        );
      },
    );
  }
}
