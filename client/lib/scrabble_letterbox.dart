import 'package:flutter/material.dart';
import 'package:scrabble_scorer/data/letter_scores.dart';

class ScrabbleLetterbox extends StatelessWidget {
  const ScrabbleLetterbox(this.letter, {super.key});

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.amber.shade300,
      ),
      child: Column(
        children: [
          Text(
            letterScores[letter].toString(),
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            letter,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
