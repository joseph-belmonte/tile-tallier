import 'package:flutter/material.dart';
import 'package:scrabble_scorer/scrabble_word.dart';

class ScrabbleGrid extends StatelessWidget {
  const ScrabbleGrid({super.key});

  @override
  Widget build(context) {
    return const Column(children: [
      Row(children: [
        Column(children: [
          Text('Player 1'),
        ]),
        Column(
          children: [
            ScrabbleWord(),
          ],
        )
      ]),
    ]);
  }
}
