import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/writing_zone.dart';

import 'models/game_state.dart';

/// A widget that displays a word as a list of ScrabbleLetterbox widgets.
class ScrabbleWordWidget extends StatelessWidget {
  final PlayedWord word;
  final bool interactive;

  const ScrabbleWordWidget(this.word, {required this.interactive, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color boxColor;

    if (word.wordMultiplier == WordMultiplier.doubleWord) {
      boxColor = Color.fromARGB(255, 240, 167, 167);
    } else if (word.wordMultiplier == WordMultiplier.tripleWord) {
      boxColor = Color.fromARGB(255, 255, 0, 0);
    } else {
      boxColor = Colors.white;
    }
    return Container(
      color: boxColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: word.playedLetters
            .map((l) => ScrabbleLetterbox(l, interactive: interactive))
            .toList(),
      ),
    );
  }
}

class ScrabbleLetterbox extends StatelessWidget {
  final PlayedLetter letter;
  final bool interactive;

  const ScrabbleLetterbox(this.letter, {required this.interactive, super.key});

  @override
  Widget build(BuildContext context) {
    // pick box color according to score multiplier
    Color boxColor;
    Color textColor;
    if (letter.letterMultiplier == LetterMultiplier.doubleLetter) {
      boxColor = Color.fromARGB(255, 167, 217, 240);
      textColor = Colors.white;
    } else if (letter.letterMultiplier == LetterMultiplier.tripleLetter) {
      boxColor = Color.fromARGB(255, 0, 112, 192);
      textColor = Colors.white;
    } else {
      boxColor = Colors.amber.shade300;
      textColor = Colors.black87;
    }
    Widget letterbox = Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: boxColor,
      ),
      child: Column(
        children: [
          Text(
            letter.score.toString(),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          Text(
            letter.letter,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );

    if (!interactive) {
      return letterbox;
    }

    return GestureDetector(
      onTap: () {
        letter.toggleLetterMultiplier();
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        Provider.of<PlayedWordState>(context, listen: false).notifyListeners();
      },
      child: letterbox,
    );
  }
}
