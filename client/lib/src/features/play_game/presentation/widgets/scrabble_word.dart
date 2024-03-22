import 'package:flutter/material.dart';

import '../../../../../enums/scrabble_edition.dart';
import '../../domain/models/word.dart';
import 'scrabble_tile.dart';

/// A widget that displays a word as a list of ScrabbleTile widgets.
class ScrabbleWordWidget extends StatefulWidget {
  /// The word to display.
  final Word word;

  /// Creates a new [ScrabbleWordWidget] instance.
  const ScrabbleWordWidget(this.word, {super.key});

  @override
  State<ScrabbleWordWidget> createState() => _ScrabbleWordWidgetState();
}

class _ScrabbleWordWidgetState extends State<ScrabbleWordWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.hardEdge,
      child: Container(
        color: widget.word.wordMultiplier.editionColor(ScrabbleEdition.classic),
        child: Row(
          children: <Widget>[
            ...widget.word.playedLetters.map((l) => ScrabbleTile(l)).toList(),
          ],
        ),
      ),
    );
  }
}
