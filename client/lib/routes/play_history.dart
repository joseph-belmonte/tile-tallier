import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';
import '../providers/active_game.dart';
import '../widgets/scrabble_tile.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Play History'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          toggle,
          SizedBox(height: 10), // Add spacing
          PlayHistoryList(interactive: interactive),
        ],
      ),
    );
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
}

class PlayHistoryList extends StatelessWidget {
  final bool interactive;

  const PlayHistoryList({required this.interactive, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plays = Provider.of<ActiveGame>(context).activeGame.plays;

    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: plays.length,
      itemBuilder: (context, index) {
        final play = plays[index];
        return SinglePlayHistoryWidget(play, interactive);
      },
    );
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
      children.add(play.isBingo ? Icon(Icons.star) : Icon(Icons.star_border));
    }

    for (var word in play.playedWords) {
      children.add(ScrabbleWordWidget(word, interactive: interactive));
    }

    if (children.isEmpty) {
      children.add(Text('Skipped'));
    }

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      margin: const EdgeInsets.all(10),
      child: Column(children: children),
    );
  }
}
