import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../current_game_state.dart';
import '../models/game_state.dart';
import '../scrabble_letterbox.dart';

class PlayHistoryPage extends StatefulWidget {
  const PlayHistoryPage({Key? key}) : super(key: key);

  @override
  PlayHistoryPageState createState() => PlayHistoryPageState();
}

class PlayHistoryPageState extends State<PlayHistoryPage> {
  bool interactive;

  PlayHistoryPageState({this.interactive = false});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...getPlayHistoryEditButtonWidgets(),
        ...getPlayHistoryWidgets(context),
      ],
    );
  }

  List<Widget> getPlayHistoryEditButtonWidgets() {
    return [
      ElevatedButton(
        onPressed: () => setState(() => interactive = !interactive),
        child: Text(interactive ? 'Done' : 'Edit History'),
      )
    ];
  }

  List<SinglePlayHistoryWidget> getPlayHistoryWidgets(BuildContext context) {
    return Provider.of<CurrentGameState>(context)
        .gameState
        .plays
        .map(
          (play) => SinglePlayHistoryWidget(
            play,
            play.player,
            interactive: interactive,
          ),
        )
        .toList();
  }
}

class SinglePlayHistoryWidget extends StatelessWidget {
  final Play play;
  final Player player;
  final bool interactive;

  const SinglePlayHistoryWidget(
    this.play,
    this.player, {
    this.interactive = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var display = play.playedWords
        .map((word) => ScrabbleWordWidget(word, interactive: interactive))
        .toList();

    return Container(
      padding: const EdgeInsets.all(5),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      margin: const EdgeInsets.all(10),
      child: Column(
        // check a conditional here and if the play is a bingo, add a star
        // if the play is empty, display a greyscale "skipped"
        children: display,
      ),
    );
  }
}
