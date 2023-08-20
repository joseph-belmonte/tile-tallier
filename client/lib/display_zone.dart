import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';

class DisplayZone extends StatelessWidget {
  const DisplayZone({super.key});

  @override
  Widget build(BuildContext context) {
    var notifier = Provider.of<GameStateNotifier>(context);

    var players = notifier.gameState.players;

    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Text(
            'Normal Mode \n',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          for (var player in players)
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        player.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Flexible(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: player.plays.length,
                      itemBuilder: (context, index) {
                        var play = player.plays[index];
                        for (var word in play.playedWords) {
                          print(
                            word.playedLetters.map((e) => e.letter).join(''),
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              play.playedWords
                                  .map(
                                    (e) => e.playedLetters.map((e) => e.letter),
                                  )
                                  .join(''),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
