import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_keyboard.dart';

class ScrabbleKey extends StatelessWidget {
  final String letter;
  const ScrabbleKey(this.letter, {super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardState = Provider.of<ScrabbleKeyboardState>(context);
    Widget keyCap;
    if (letter == "_") {
      keyCap = const Icon(
        Icons.keyboard_return_rounded,
        color: Colors.white,
        size: 14,
      );
    } else if (letter == "<") {
      keyCap = const Icon(
        Icons.backspace,
        color: Colors.white,
        size: 14,
      );
    } else {
      keyCap = TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: () {},
        child: Text(
          letter,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        keyboardState.type(letter);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          letter,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
