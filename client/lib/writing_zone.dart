import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_keyboard.dart';
import 'package:scrabble_scorer/scrabble_letterbox.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';

import './data/letter_scores.dart';

class WritingZone extends StatefulWidget {
  const WritingZone({super.key});

  @override
  State<WritingZone> createState() => _WritingZoneState();
}

class _WritingZoneState extends State<WritingZone> {
  String currentWord = '';
  bool useCustomKeyboard = true;
  final _textController = TextEditingController();

  int get currentWordScore {
    int score = 0;
    for (var char in currentWord.split('')) {
      score += letterScores[char.toUpperCase()] ?? 0;
    }
    return score;
  }

  void toggleKeyboard() {
    setState(() {
      useCustomKeyboard = !useCustomKeyboard;
    });
  }

  Widget buildKeyboard() {
    if (useCustomKeyboard) {
      return ScrabbleKeyboard(
          onTapCallback: (letter) => setState(() {
                currentWord += letter;
              }),
          onSubmitCallback: (_) => setState(() {
                Provider.of<GameStateNotifier>(context, listen: false)
                    .addWord(currentWord);
                currentWord = '';
              }));
    }
    return TextField(
      controller: _textController,
      onChanged: (word) => setState(() {
        currentWord = word;
      }),
      onSubmitted: (value) {
        Provider.of<GameStateNotifier>(context, listen: false).addWord(value);
        setState(() {
          currentWord = '';
        });
        _textController.clear();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter a word',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the score based on typed text and letter modifiers

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
              for (var char in currentWord.split(''))
                GestureDetector(
                  onTap: () {
                    print('Letter $char tapped');
                  },
                  child: ScrabbleLetterbox(
                    char.toUpperCase(),
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.pink,
                  padding: EdgeInsets.all(5),
                  child:
                      Text(currentWord, style: const TextStyle(fontSize: 20)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: useCustomKeyboard,
                      onChanged: (value) => toggleKeyboard(),
                    ),
                    Text('Toggle'),
                  ],
                ),
              ),
            ],
          ),
          buildKeyboard(),
        ],
      ),
    );
  }
}
