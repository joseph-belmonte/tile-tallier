import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'current_game_state.dart';
import 'helpers/get_score_multiplier_label.dart';
import 'keyboard.dart';
import 'models/game_state.dart';
import 'scrabble_letterbox.dart';

class CurrentPlayState extends ChangeNotifier {
  PlayedWord playedWord = PlayedWord();

  /// Sets the displayed text to the given text and updates the list of
  /// played letters to match the text
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
    playedWord.toggleWordMultiplier();
    notifyListeners();
  }
}

class WritingZone extends StatefulWidget {
  const WritingZone({super.key});

  @override
  State<WritingZone> createState() => _WritingZoneState();
}

class _WritingZoneState extends State<WritingZone> {
  bool isChecked = false;

  void onChanged(bool? newValue) {
    setState(() {
      Provider.of<CurrentGameState>(context, listen: false).toggleBingo();
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    var notifier = Provider.of<CurrentGameState>(context, listen: true);
    var activePlayerIndex = notifier.gameState.activePlayerIndex;

    var currentPlayState = Provider.of<CurrentPlayState>(context, listen: true);

    void onAddWord(context) {
      currentPlayState.playWord(context);
    }

    void onSwitchPlayer(context) {
      notifier.endTurn();
      setState(() {
        activePlayerIndex = notifier.gameState.activePlayerIndex;
        isChecked = false;
      });
    }

    var turnActions = Column(
      children: <Widget>[
        FloatingActionButton(
          // Add word button
          mini: true,
          onPressed: () => onAddWord(context),
          child: Icon(Icons.add_circle_outline),
        ),
        FloatingActionButton(
          // Switch player button
          mini: true,
          onPressed: () => onSwitchPlayer(context),
          child: Icon(Icons.switch_account_rounded),
        ),
        FloatingActionButton(
          // Settings button
          mini: true,
          onPressed: () {
            print('Redirect to settings page not implemented');
          },
          child: Icon(Icons.settings_suggest_rounded),
        ),
      ],
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TurnDisplay(
                player: notifier.gameState.players[activePlayerIndex],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: CheckboxListTile(
                      title: Text('Bingo'),
                      value: isChecked,
                      onChanged: onChanged,
                    ),
                  ),
                ],
              ),
              turnActions,
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.hardEdge,
            child: ScrabbleWordWidget(
              currentPlayState.playedWord,
              interactive: true,
            ),
          ),
          Keyboard(),
        ],
      ),
    );
  }
}

class TurnDisplay extends StatelessWidget {
  final Player player;

  const TurnDisplay({required this.player, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Current Player:',
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Icon(Icons.person_rounded),
              Consumer<CurrentGameState>(
                builder: (context, gameStateNotifier, child) {
                  return Text(
                    gameStateNotifier.gameState.activePlayer.name,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Word Score: ',
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Consumer<CurrentPlayState>(
                builder: (context, currentPlayState, child) {
                  return Text(
                    '${currentPlayState.playedWord.score}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                },
              ),
              Consumer<CurrentPlayState>(
                builder: (context, currentPlayState, child) {
                  return OutlinedButton.icon(
                    icon: Icon(Icons.multiple_stop_rounded),
                    onPressed: () => currentPlayState.toggleWordMultiplier(),
                    label: Text(
                      getScoreMultiplierLabel(
                        currentPlayState.playedWord.wordMultiplier,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
