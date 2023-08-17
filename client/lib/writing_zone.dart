import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_letterbox.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';

import './data/letter_scores.dart';
import 'keyboard/keyboard.dart';

class WritingZone extends StatefulWidget {
  const WritingZone({super.key});

  @override
  State<WritingZone> createState() => WritingZoneState();
}

class WritingZoneState extends State<WritingZone> {
  String _currentWord = '';

  String get currentWord => _currentWord;
  set currentWord(String word) => setState(() => _currentWord = word);

  int get currentWordScore {
    int score = 0;
    for (var char in currentWord.split('')) {
      score += letterScores[char.toUpperCase()] ?? 0;
    }
    return score;
  }

  void submitCurrentWord() {
    Provider.of<GameStateNotifier>(context, listen: false).addWord(currentWord);
    currentWord = '';
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Word Score: $currentWordScore', // Display current word score
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: currentWord
                .toUpperCase()
                .split('')
                .map((c) => ScrabbleLetterbox(c))
                .toList(),
          ),
          KeyboardWidget(this),
        ],
      ),
    );
  }
}
