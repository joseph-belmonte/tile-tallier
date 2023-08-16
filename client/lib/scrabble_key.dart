import 'package:flutter/material.dart';

class ScrabbleKey extends StatelessWidget {
  const ScrabbleKey(this.letter, this.onTapCallback, this.onSubmitCallback,
      {super.key});

  final String letter;
  final Function onTapCallback;
  final Function onSubmitCallback;

  @override
  Widget build(BuildContext context) {
    Widget keyChild;
    Function callback;

    if (letter == '_') {
      keyChild = Icon(Icons.keyboard_return);
      callback = onSubmitCallback;
    } else if (letter == '<') {
      keyChild = Icon(Icons.backspace);
      callback = onTapCallback;
    } else {
      keyChild = Text(letter, style: const TextStyle(fontSize: 20));
      callback = onTapCallback;
    }

    return GestureDetector(
      onTap: () => callback(letter),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: keyChild,
      ),
    );
  }
}
