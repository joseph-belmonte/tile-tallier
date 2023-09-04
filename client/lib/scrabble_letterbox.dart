import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/writing_zone.dart';

import 'models/game_state.dart';

/// A widget that displays a word as a list of ScrabbleLetterbox widgets.
class ScrabbleWordWidget extends StatefulWidget {
  final PlayedWord word;
  final bool interactive;

  const ScrabbleWordWidget(this.word, {required this.interactive, super.key});

  @override
  ScrabbleWordWidgetState createState() => ScrabbleWordWidgetState();
}

class ScrabbleWordWidgetState extends State<ScrabbleWordWidget> {
  Color boxColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    toggleWordScoreColor();
    return GestureDetector(
      onTap: () {
        if (!widget.interactive) return;
        widget.word.toggleWordMultiplier();
        toggleWordScoreColor();
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        Provider.of<CurrentPlayState>(context, listen: false).notifyListeners();
      },
      child: Container(
        color: boxColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.word.playedLetters
              .map((l) => ScrabbleLetterbox(l, interactive: widget.interactive))
              .toList(),
        ),
      ),
    );
  }

  void toggleWordScoreColor() {
    if (widget.word.wordMultiplier == WordMultiplier.doubleWord) {
      boxColor = Color.fromARGB(255, 240, 167, 167);
    } else if (widget.word.wordMultiplier == WordMultiplier.tripleWord) {
      boxColor = Color.fromARGB(255, 255, 0, 0);
    } else {
      boxColor = Colors.white;
    }
    setState(() {});
  }
}

/// A widget that displays a single letter as a ScrabbleLetterbox widget.
class ScrabbleLetterbox extends StatefulWidget {
  final PlayedLetter letter;
  final bool interactive;

  const ScrabbleLetterbox(this.letter, {required this.interactive, super.key});

  @override
  ScrabbleLetterboxState createState() => ScrabbleLetterboxState();
}

class ScrabbleLetterboxState extends State<ScrabbleLetterbox> {
  Color boxColor = Colors.amber.shade300;
  Color textColor = Colors.black87;

  @override
  Widget build(BuildContext context) {
    toggleLetterBoxDisplay();
    return GestureDetector(
      onTap: () {
        if (!widget.interactive) return;
        widget.letter.toggleLetterMultiplier();
        toggleLetterBoxDisplay();
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        Provider.of<CurrentPlayState>(context, listen: false).notifyListeners();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          color: boxColor,
        ),
        child: Column(
          children: [
            Text(
              widget.letter.score.toString(),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            Text(
              widget.letter.letter,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleLetterBoxDisplay() {
    switch (widget.letter.letterMultiplier) {
      case LetterMultiplier.doubleLetter:
        boxColor = Color.fromARGB(255, 167, 217, 240);
        textColor = Colors.white;
        break;
      case LetterMultiplier.tripleLetter:
        boxColor = Color.fromARGB(255, 0, 112, 192);
        textColor = Colors.white;
        break;
      default:
        boxColor = Colors.amber.shade300;
        textColor = Colors.black87;
        break;
    }
    setState(() {});
  }
}
