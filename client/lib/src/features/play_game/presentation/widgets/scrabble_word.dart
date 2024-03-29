import 'package:flutter/material.dart';

import '../../domain/models/word.dart';
import 'scrabble_tile.dart';

/// A widget that displays a word as a list of ScrabbleTile widgets.
class ScrabbleWordWidget extends StatefulWidget {
  /// The word to display.
  final Word word;

  /// The callback to call when a letter is tapped.
  final void Function(int) onLetterTap;

  /// Creates a new [ScrabbleWordWidget] instance.
  const ScrabbleWordWidget(this.word, this.onLetterTap, {super.key});

  @override
  State<ScrabbleWordWidget> createState() => _ScrabbleWordWidgetState();
}

class _ScrabbleWordWidgetState extends State<ScrabbleWordWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: <Widget>[
          ...widget.word.playedLetters.asMap().entries.map((entry) {
            final idx = entry.key;
            final letter = entry.value;
            return ScrabbleTile(
              letter,
              () => widget.onLetterTap(idx),
            );
          }),
        ],
      ),
    );
  }
}
