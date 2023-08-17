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

  void onSubmitWord(BuildContext context) {
    /// Add the current word to the list of words for the active player
    var gameState = Provider.of<GameStateNotifier>(context, listen: false);
    gameState.addWord(currentWord);
    currentWord = '';
  }

  @override
  Widget build(BuildContext context) {
    var notifier = Provider.of<GameStateNotifier>(context);
    var players = notifier.gameState.players;
    var activePlayerIndex = notifier.activePlayerIndex;

    var turnActionButtons = [
      FloatingActionButton.small(
        // Add word button
        onPressed: () => onSubmitWord(context),
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
              children: currentWord
                  .toUpperCase()
                  .split('')
                  .map((c) => ScrabbleLetterbox(c))
                  .toList(),
            ),
          ),
          KeyboardWidget(this),
        ],
      ),
    );
  }
}
