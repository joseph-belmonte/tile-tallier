import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../current_game_state.dart';
import '../models/game_state.dart';
import '../scrabble_tile.dart';

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
    Widget toggle = interactive ? getLockButton() : getEditButton();
    return ListView(children: [toggle, ...getPlayHistoryWidgets(context)]);
  }

  Widget getLockButton() {
    return ElevatedButton(
      onPressed: () => setState(() => interactive = false),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.lock, color: Colors.white),
          Text('Lock Play History', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget getEditButton() {
    return ElevatedButton(
      onPressed: () => setState(() => interactive = true),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.edit, color: Colors.white),
          Text('Edit Play History', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  List<SinglePlayHistoryWidget> getPlayHistoryWidgets(BuildContext context) {
    return Provider.of<CurrentGameState>(context)
        .gameState
        .plays
        .map((play) => SinglePlayHistoryWidget(play, interactive))
        .toList();
  }
}

class SinglePlayHistoryWidget extends StatelessWidget {
  final Play play;
  final bool interactive;

  const SinglePlayHistoryWidget(this.play, this.interactive, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [Text(play.player.name)];

    if (!interactive) {
      children.add(Text('Score: ${play.score}'));
    }

    for (var word in play.playedWords) {
      children.add(ScrabbleWordWidget(word, interactive: interactive));
    }

    if (children.isEmpty) {
      children.add(Text('Skipped'));
    } else if (play.isBingo) {
      children.add(Icon(Icons.star));
    }

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      margin: const EdgeInsets.all(10),
      child: Column(children: children),
    );
  }
}
