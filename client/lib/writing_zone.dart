import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_keyboard.dart';
import 'package:scrabble_scorer/scrabble_letterbox.dart';
import './data/letter_scores.dart';

class WritingZone extends StatefulWidget {
  const WritingZone({super.key});

  @override
  _WritingZoneState createState() => _WritingZoneState();
}

class _WritingZoneState extends State<WritingZone> {
  // Current score variable
  int score = 0;

  Map<String, int> letterMultipliers = {
    'DL': 2,
    'TL': 3,
  };

  Map<String, int> wordMultipliers = {
    'DW': 2,
    'TW': 3,
  };

  @override
  Widget build(BuildContext context) {
    var scrabbleKeyboardState = Provider.of<ScrabbleKeyboardState>(context);

    // Calculate the score based on typed text and letter modifiers
    int currentWordScore = 0;
    for (var char in scrabbleKeyboardState.typedText.split('')) {
      currentWordScore += (letterScores[char]!);
    }

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
            children: [
              for (var char in scrabbleKeyboardState.typedText.split(''))
                GestureDetector(
                  onTap: () {
                    print('Letter $char tapped');
                  },
                  child: ScrabbleLetterbox(
                    char,
                  ),
                ),
            ],
          ),
          Container(
            color: Colors.pink,
            padding: EdgeInsets.all(5),
            width: double.infinity,
            child: Text(
              scrabbleKeyboardState.typedText,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ScrabbleKeyboard(),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  // void _toggleLetterModifier(String letter) {
  //   if (letterModifiers[letter] == null) {
  //     switch (letterModifiers[letter]) {
  //       case 'DL':
  //         letterModifiers[letter] = 'TL';
  //         break;
  //       case 'TL':
  //         letterModifiers[letter] = 'DW';
  //         break;
  //       default:
  //         letterModifiers[letter] = 'DL';
  //     }
  //   }

  //   setState(() {});
  // }
}
