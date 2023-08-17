import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_letterbox.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';

import './data/letter_scores.dart';
import 'keyboard/keyboard.dart';

class PlayedWordState extends ChangeNotifier {
  String _currentWord = '';

  String get currentWord => _currentWord;
  set currentWord(String word) {
    _currentWord = word;
    notifyListeners();
  }

  int get currentWordScore {
    int score = 0;
    for (var char in currentWord.split('')) {
      score += letterScores[char.toUpperCase()] ?? 0;
    }
    return score;
  }

  void playWord(BuildContext context) {
    /// Add the current word to the list of words for the active player
    var gameState = Provider.of<GameStateNotifier>(context, listen: false);
    gameState.addWord(currentWord);
    currentWord = '';
    notifyListeners();
  }
}

class WritingZone extends StatefulWidget {
  const WritingZone({super.key});

  @override
  State<WritingZone> createState() => _WritingZoneState();
}

class _WritingZoneState extends State<WritingZone> {
  @override
  Widget build(BuildContext context) {
    var notifier = Provider.of<GameStateNotifier>(context);
    var playedWordState = Provider.of<PlayedWordState>(context);
    var players = notifier.gameState.players;
    var activePlayerIndex = notifier.activePlayerIndex;

    var turnActionButtons = [
      FloatingActionButton.small(
        // Add word button
        onPressed: () => playedWordState.playWord(context),
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
        'Word Score: ${playedWordState.currentWordScore}',
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
              children: playedWordState.currentWord
                  .toUpperCase()
                  .split('')
                  .map((c) => ScrabbleLetterbox(c))
                  .toList(),
            ),
          ),
          KeyboardWidget(),
        ],
      ),
    );
  }
}
