import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_keyboard.dart';

class ScrabbleKey extends StatelessWidget {
  const ScrabbleKey(this.letter, {super.key});

  final String letter;

  @override
  Widget build(BuildContext context) {
    final keyboardState = Provider.of<ScrabbleKeyboardState>(context);


    Widget keyChild;

    if (letter == '_') {
      keyChild = Icon(Icons.keyboard_return);
    } else if (letter == '<') {
      keyChild = Icon(Icons.backspace);
    } else {
      keyChild = Text(letter, style: const TextStyle(fontSize: 20));
    }

    return GestureDetector(
      onTap: () => keyboardState.type(letter),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: keyChild,

      ),
    );
  }
}
