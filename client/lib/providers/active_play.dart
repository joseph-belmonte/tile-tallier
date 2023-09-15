import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';
import 'active_game.dart';

class ActivePlay extends ChangeNotifier {
  Play? play;
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
    Provider.of<ActiveGame>(context, listen: false).addWordToCurrentPlay(playedWord);

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

  /// Starts the next player's turn
  void startTurn(BuildContext context) {
    var game = Provider.of<ActiveGame>(context, listen: false);
    game.activeGame.endTurn();
    play = game.activeGame.currentPlay;
    notifyListeners();
  }

  void toggleBingo() {
    play!.isBingo = !play!.isBingo;
    notifyListeners();
  }
}
