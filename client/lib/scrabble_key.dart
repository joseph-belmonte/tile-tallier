import 'package:flutter/material.dart';

class ScrabbleKey extends StatelessWidget {
  final String letter;
  const ScrabbleKey(this.letter, {super.key});

  @override
  Widget build(BuildContext context) {
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
      keyCap = Text(
        letter,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      );
    }

    return Container(
        width: 30,
        height: 50,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: Colors.black87, width: 1),
            borderRadius: BorderRadius.circular(4)),
        child: keyCap);
  }
}
