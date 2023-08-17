import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';

class DisplayZone extends StatelessWidget {
  const DisplayZone({super.key});

  @override
  Widget build(BuildContext context) {
    var notifier = Provider.of<GameStateNotifier>(context);
    final playedWords = notifier.playedWords;

    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          SizedBox(
            height: 55,
          ),
          Text(
            'Played Words:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          playedWords.isNotEmpty
              ? Column(
                  children: [
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
              : Text(
                  'No words yet...',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                ),
        ],
      ),
    );
  }
}
