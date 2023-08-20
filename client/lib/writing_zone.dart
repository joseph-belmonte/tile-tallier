import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_letterbox.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';

import 'keyboard/keyboard.dart';
import 'models/game_state.dart';

class PlayedWordState extends ChangeNotifier {
  List<PlayedLetter> playedLetters = [];

  // return word from playedLetters
  String get wordAsString => playedLetters.map((e) => e.letter).join();

  // return word as PlayedWord
  PlayedWord get wordAsPlayedWord => PlayedWord(playedLetters);

  /// returns the score of the current word
  int get score {
    return wordAsPlayedWord.score;
  }

  /// sets playedLetters to the letters of a given string
  void setPlayedLetters(String letters) {
    playedLetters = letters.split('').map((e) => PlayedLetter(e)).toList();
    notifyListeners();
  }

  /// Add the current word to the list of words for the active player
  void playWord(BuildContext context) {
    var gameState = Provider.of<GameStateNotifier>(context, listen: false);
    gameState.addWord(wordAsPlayedWord);
    playedLetters = [];
    notifyListeners();
  }

  /// Removes the last letter from the current word
  void removeLetter() {
    if (playedLetters.isNotEmpty) {
      playedLetters.removeLast();
      notifyListeners();
    }
  }

  /// Accepts a letter of type String and adds it as a PlayedLetter to the
  /// current of list of playedLetters
  void playLetter(String letter) {
    playedLetters.add(PlayedLetter(letter));
    notifyListeners();
  }

  void notify() {
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
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Current Player:',
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          Text(
            //TODO: long names will overflow and break app
            players[activePlayerIndex].name,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Word Score: ',
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          Text(
            '${playedWordState.score}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ];
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
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
              children: playedWordState.playedLetters
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
