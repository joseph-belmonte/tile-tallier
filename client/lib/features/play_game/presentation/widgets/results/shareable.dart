import 'package:flutter/material.dart';

import '../../../../../utils/helpers.dart';
import '../../../../core/domain/models/game.dart';
import '../gameplay/scrabble_word.dart';

/// A widget that displays an item to share.
class Shareable extends StatelessWidget {
  /// The game to share.
  final Game game;

  /// Creates a [Shareable] widget.
  const Shareable({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const <Color>[
            Colors.black87,
            Colors.black12,
          ],
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'I scored my game on TileTallier and ${game.sortedPlayers[0].name} won!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 8.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: game.sortedPlayers.length,
            itemBuilder: (_, index) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.emoji_events,
                        size: 24.0,
                        color: getIconColor(index) ??
                            Theme.of(context).colorScheme.onSurface,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        ' ${game.sortedPlayers[index].name}: ${game.sortedPlayers[index].score}',
                        style: index == 0
                            ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                )
                            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 8.0),
          Text('Highest Scoring Word:'),
          SizedBox(height: 8.0),
          FittedBox(
            child: ScrabbleWordWidget(game.highestScoringWord, (_) {}),
          ),
          SizedBox(height: 8.0),
          Text(
            '${game.highestScoringWord.score} points!',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      ),
    );
  }
}
