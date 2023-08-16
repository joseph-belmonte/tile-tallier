import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final _textController = TextEditingController();

  int get currentWordScore {
    int score = 0;
    for (var char in currentWord.split('')) {
      score += letterScores[char.toUpperCase()] ?? 0;
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    var notifier = Provider.of<GameStateNotifier>(context);
    var players = notifier.gameState.players;
    var activePlayerIndex = notifier.activePlayerIndex;

    void onSubmitWord() {
      /// Add the current word to the list of words for the active player
      notifier.addWord(currentWord);
      setState(() {
        currentWord = '';
      });
      _textController.clear();
    }

    var turnActionButtons = [
      FloatingActionButton.small(
        // Add word button
        onPressed: onSubmitWord,
        child: Icon(Icons.add_circle_outline),
      ),
      FloatingActionButton.small(
        // Switch player button
        onPressed: () {
          notifier.endTurn();
          setState(() {
            activePlayerIndex = notifier.activePlayerIndex;
          });
        },
        child: Icon(Icons.switch_account_rounded),
      ),
    ];

    var writingDisplayText = [
      Text(
        'Current Player: ${players[activePlayerIndex].name}',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      Text(
        'Word Score: $currentWordScore',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    ];
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: writingDisplayText,
              ),
              Spacer(),
              Column(
                children: turnActionButtons,
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.hardEdge,
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
          ),
          Container(
            color: Colors.pink,
            padding: EdgeInsets.all(5),
            width: double.infinity,
            child: Text(currentWord, style: const TextStyle(fontSize: 20)),
          ),
          TextField(
            controller: _textController,
            onChanged: (value) {
              setState(() {
                currentWord = value;
              });
            },
            onSubmitted: (value) {
              onSubmitWord();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter a word',
            ),
          ),
        ],
      ),
    );
  }
}
