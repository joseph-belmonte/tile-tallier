import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/display_zone.dart';
import '../widgets/writing_zone.dart';

import '../providers/active_game.dart';
import '../models/game.dart';
import './game_end/subtract.dart';

class PlayInputPage extends StatefulWidget {
  static const endGameButton = EndGameButton();

  static const writingZone = WritingZone();
  const PlayInputPage({super.key});

  @override
  State<PlayInputPage> createState() => _PlayInputPageState();
}

class _PlayInputPageState extends State<PlayInputPage> {
  bool displayScores = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Input'),
      ),
      body: Selector<ActiveGame, List<Player>>(
        selector: (_, activeGame) => activeGame.players,
        builder: (_, players, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  PlayInputPage.endGameButton,
                  ElevatedButton.icon(
                    icon: displayScores ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                    label: Text('Scores'),
                    onPressed: () => setState(() {
                      displayScores = !displayScores;
                    }),
                  ),
                ],
              ),
              PlayerScoreCards(players, displayScores: displayScores),
              PlayInputPage.writingZone,
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
