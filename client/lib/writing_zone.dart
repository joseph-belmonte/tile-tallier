import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_letterbox.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';

import './data/letter_scores.dart';
import 'keyboard/keyboard.dart';

class PlayedWordState extends ChangeNotifier {
  String _word = '';

  String get word => _word;
  set word(String newWord) {
    _word = newWord;
    notifyListeners();
  }

  int get score {
    int letterScoreSum = 0;
    for (var letter in word.split('')) {
      letterScoreSum += letterScores[letter.toUpperCase()] ?? 0;
    }
    return letterScoreSum;
  }

  void playWord(BuildContext context) {
    /// Add the current word to the list of words for the active player
    var gameState = Provider.of<GameStateNotifier>(context, listen: false);
    gameState.addWord(word);
    word = '';
    notifyListeners();
  }

  void backspace() {
    if (word.isNotEmpty) word = word.substring(0, word.length - 1);
  }

  void type(String letter) => word += letter;
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
        'Word Score: ${playedWordState.score}',
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
              children: playedWordState.word
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
