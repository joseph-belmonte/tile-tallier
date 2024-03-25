import 'package:flutter/material.dart';

import '../../domain/models/play.dart';
import 'scrabble_word.dart';

/// A widget to display a historical play.
class HistoricalPlay extends StatelessWidget {
  /// The play to display.
  final Play play;

  /// Whether the play is interactive.
  final bool interactive;

  /// Creates a new [HistoricalPlay] instance.
  const HistoricalPlay(this.play, this.interactive, {super.key});

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[Text(play.playedWords.toString())];

    if (!interactive) {
      children.add(Text('Score: ${play.score}'));
      children.add(play.isBingo ? Icon(Icons.star) : Icon(Icons.star_border));
    }

    for (var word in play.playedWords) {
      // TODO: clean this up for the letter tap functionality when editing
      children.add(ScrabbleWordWidget(word, (value) {}));
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
