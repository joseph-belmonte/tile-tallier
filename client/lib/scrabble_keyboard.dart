import 'package:flutter/material.dart';

import 'scrabble_key.dart';

class ScrabbleKeyboard extends StatelessWidget {
  const ScrabbleKeyboard({super.key});

  @override
  Widget build(context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [for (var i in "QWERTYUIOP".split("")) ScrabbleKey(i)],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [for (var i in "ASDFGHJKL".split("")) ScrabbleKey(i)],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [for (var i in "_ZXCVBNM<".split("")) ScrabbleKey(i)],
      ),
    ]);
  }
}
