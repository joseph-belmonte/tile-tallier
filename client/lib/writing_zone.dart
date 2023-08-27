import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_state.dart';
import 'helpers/get_score_multiplier_label.dart';
import 'keyboard/keyboard.dart';
import 'models/game_state.dart';
import 'scrabble_letterbox.dart';

class PlayedWordState extends ChangeNotifier {
  PlayedWord playedWord = PlayedWord();

  void updatePlayedWord(String text) {
    String word = playedWord.word;
    int i = 0;

    // set text and word to uppercase for comparison
    text = text.toUpperCase();
    word = word.toUpperCase();

    while (i < word.length && i < text.length && word[i] == text[i]) {
      i++;
    }
    if (i == 0) {
      playedWord.playedLetters.clear();
    } else if (i < word.length) {
      playedWord.playedLetters.removeRange(i, playedWord.playedLetters.length);
    }
    while (i < text.length) {
      playedWord.playedLetters.add(PlayedLetter(text[i]));
      i++;
    }
    notifyListeners();
  }

  /// Add the current word to the list of words for the active player
  void playWord(BuildContext context) {
    Provider.of<CurrentGameState>(context, listen: false)
        .addWordToCurrentPlay(playedWord);
    playedWord = PlayedWord();
    notifyListeners();
  }

  /// Removes the last letter from the current word
  void removeLetter() {
    if (playedWord.playedLetters.isNotEmpty) {
      playedWord.playedLetters.removeLast();
    }
    notifyListeners();
  }

  /// Accepts a letter of type String and adds it as a PlayedLetter to the
  /// current of list of playedLetters
  void playLetter(String letter) {
    playedWord.playedLetters.add(PlayedLetter(letter));
    notifyListeners();
  }

  /// Toggles the word multiplier for the current word
  void toggleWordMultiplier() {
    switch (playedWord.wordMultiplier) {
      case WordMultiplier.none:
        playedWord.wordMultiplier = WordMultiplier.doubleWord;
      case WordMultiplier.doubleWord:
        playedWord.wordMultiplier = WordMultiplier.tripleWord;
      case WordMultiplier.tripleWord:
        playedWord.wordMultiplier = WordMultiplier.none;
    }
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
    var notifier = Provider.of<CurrentGameState>(context, listen: true);
    var activePlayerIndex = notifier.activePlayerIndex;

    var playedWordState = Provider.of<PlayedWordState>(context, listen: true);

    var wordMultiplierText = Text(
      getScoreMultiplierLabel(playedWordState.playedWord.wordMultiplier),
    );

    var turnActionButtons = [
      FloatingActionButton(
        // Add word button
        mini: true,
        onPressed: () => playedWordState.playWord(context),
        child: Icon(Icons.add_circle_outline),
      ),
      FloatingActionButton(
        // Switch player button
        mini: true,
        onPressed: () {
          notifier.endTurn();
          setState(() {
            activePlayerIndex = notifier.activePlayerIndex;
          });
        },
        child: Icon(Icons.switch_account_rounded),
      ),
      FloatingActionButton(
        // Settings button
        mini: true,
        onPressed: () {
          // TODO: Implement settings page
          print('Redirect to settings page not implemented');
        },
        child: Icon(Icons.settings_suggest_rounded),
      ),
    ];

    var turnInfoText = [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
          Icon(Icons.person_rounded),
          Consumer<CurrentGameState>(
            builder: (context, gameStateNotifier, child) {
              return Text(
                gameStateNotifier.gameState.players[activePlayerIndex].name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              );
            },
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
          Consumer<PlayedWordState>(
            builder: (context, playedWordState, child) {
              return Text(
                '${playedWordState.playedWord.score}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              );
            },
          ),
          Consumer<PlayedWordState>(
            builder: (context, playedWordState, child) {
              return OutlinedButton.icon(
                icon: Icon(Icons.multiple_stop_rounded),
                onPressed: () {
                  playedWordState.toggleWordMultiplier();
                },
                label: wordMultiplierText,
              );
            },
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: turnInfoText,
                ),
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
            child: ScrabbleWordWidget(
              playedWordState.playedWord,
              interactive: true,
            ),
          ),
          KeyboardWidget(),
        ],
      ),
    );
  }
}
