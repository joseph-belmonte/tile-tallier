import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/writing_zone.dart';

import 'models/game_state.dart';

class ScrabbleLetterbox extends StatefulWidget {
  final PlayedLetter letter;
  const ScrabbleLetterbox(this.letter, {super.key});

  @override
  State<ScrabbleLetterbox> createState() => _ScrabbleLetterboxState(letter);
}

class _ScrabbleLetterboxState extends State<ScrabbleLetterbox> {
  final PlayedLetter letter;

  _ScrabbleLetterboxState(this.letter);

  void toggleLetterMultiplier() {
    if (letter.isDouble) {
      letter.isDouble = false;
      letter.isTriple = true;
    } else if (letter.isTriple) {
      letter.isTriple = false;
    } else {
      letter.isDouble = true;
    }
    setState(() {});
    Provider.of<PlayedWordState>(context, listen: false).notify();
  }

  @override
  Widget build(BuildContext context) {
    // pick box color according to score multiplier
    Color boxColor;
    Color textColor;
    if (letter.isDouble) {
      boxColor = Color.fromARGB(255, 167, 217, 240);
      textColor = Colors.white;
    } else if (letter.isTriple) {
      boxColor = Color.fromARGB(255, 0, 112, 192);
      textColor = Colors.white;
    } else {
      boxColor = Colors.amber.shade300;
      textColor = Colors.black87;
    }
    return GestureDetector(
      onTap: () => toggleLetterMultiplier(),
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
      ),
    );
  }
}
