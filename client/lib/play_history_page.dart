import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_state.dart';
import 'models/game_state.dart';
import 'scrabble_letterbox.dart';

class PlayHistoryPage extends StatelessWidget {
  const PlayHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: Provider.of<CurrentGameState>(context)
          .gameState
          .plays
          .map((play) => SinglePlayHistoryWidget(play, play.player))
          .toList(),
    );
  }
}

class SinglePlayHistoryWidget extends StatelessWidget {
  final Play play;
  final Player player;

  const SinglePlayHistoryWidget(this.play, this.player, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: play.playedWords
            .map((word) => ScrabbleWordWidget(word, interactive: false))
            .toList(),
      ),
    );
  }
}
