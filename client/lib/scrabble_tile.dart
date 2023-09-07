import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/writing_zone.dart';

import 'app_state.dart';
import 'models/game.dart';

/// A widget that displays a word as a list of ScrabbleTile widgets.
class ScrabbleWordWidget extends StatefulWidget {
  final PlayedWord word;
  final bool interactive;

  const ScrabbleWordWidget(this.word, {required this.interactive, super.key});

  @override
  ScrabbleWordWidgetState createState() => ScrabbleWordWidgetState();
}

class ScrabbleWordWidgetState extends State<ScrabbleWordWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.interactive) return;
        widget.word.toggleWordMultiplier();
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        Provider.of<CurrentPlayState>(context, listen: false).notifyListeners();
        setState(() {});
      },
      child: _buildTileWrapperWidget(),
    );
  }

  Widget _buildTileWrapperWidget() {
    return Consumer<AppState>(
      builder: (_, appState, __) {
        return Container(
          color: widget.word.wordMultiplier.editionColor(appState.edition),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.word.playedLetters
                .map((l) => ScrabbleTile(l, interactive: widget.interactive))
                .toList(),
          ),
        );
      },
    );
  }
}

/// A widget that displays a single letter as a ScrabbleTile widget.
class ScrabbleTile extends StatefulWidget {
  final PlayedLetter letter;
  final bool interactive;

  const ScrabbleTile(this.letter, {required this.interactive, super.key});

  @override
  ScrabbleTileState createState() => ScrabbleTileState();
}

class ScrabbleTileState extends State<ScrabbleTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.interactive) return;
        widget.letter.toggleLetterMultiplier();
        setState(() {});
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        Provider.of<CurrentPlayState>(context, listen: false).notifyListeners();
      },
      child: Consumer<AppState>(
        builder: (_, appState, __) {
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              color: widget.letter.letterMultiplier.editionColor(appState.edition),
            ),
            child: Column(
              children: [
                Text(
                  widget.letter.score.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.letter.letter,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
