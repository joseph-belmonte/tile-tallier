import 'package:flutter/material.dart';

import 'scrabble_letterbox.dart';

const rows = 1;

const word = 'ABCD';

class ScrabbleWord extends StatelessWidget {
  const ScrabbleWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Row(children: [
        for (var i = 0; i < word.length; i++) ScrabbleLetterbox(word[i]),
      ]),
    ]);
  }
}
