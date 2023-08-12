import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/models/game_state.dart';

import 'scrabble_keyboard.dart';

class DisplayZone extends StatefulWidget {
  DisplayZone({super.key});

  @override
  State<DisplayZone> createState() => _DisplayZoneState();
}

class _DisplayZoneState extends State<DisplayZone> {
  GameState gameState = GameState(players: [
    Player(name: 'Joe'),
    Player(name: 'J.I.'),
  ]);

  int activePlayerIndex = 0;

  void nextPlayer() {
    activePlayerIndex = (activePlayerIndex + 1) % gameState.players.length;
  }

  final List<List<String>> playedWords = [];

  void addWord(String word) {
    playedWords.add([word, gameState.players[activePlayerIndex].name]);
  }

  void removeWord(String word) {
    playedWords.remove(word);
  }

  @override
  Widget build(BuildContext context) {
    final scrabbleKeyboardState = Provider.of<ScrabbleKeyboardState>(context);

    if (scrabbleKeyboardState.wordEntered) {
      addWord(scrabbleKeyboardState.typedText);

      scrabbleKeyboardState.wordEntered = false;
      scrabbleKeyboardState.typedText = '';
      nextPlayer();
    }

    print(playedWords);
    print(scrabbleKeyboardState.typedText);
    print(scrabbleKeyboardState.wordEntered);

    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          SizedBox(
            height: 55,
          ),
          playedWords.isNotEmpty
              ? Column(
                  children: [
                    Text(
                      'Played Words:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    for (var wordPlayerPair in playedWords)
                      Row(
                        children: [
                          Text(
                            '${wordPlayerPair[0]} - ${wordPlayerPair[1]}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      )
                  ],
                )
              : Placeholder(
                  fallbackHeight: 40,
                ),
        ],
      ),
    );
  }
}
