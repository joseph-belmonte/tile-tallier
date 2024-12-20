import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../core/domain/models/game.dart';
import 'past_game_list_item.dart';

/// A list of past games, sorted by date.
class PastGameList extends StatelessWidget {
  /// Whether this list is displaying favorite games.
  final List<Game> games;

  /// Creates a new [PastGameList] instance.
  const PastGameList({required this.games, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (_, index) {
        final animationDuration = games.length == 1
            ? Durations.medium4
            : Durations.extralong1 ~/ (games.length - index);

        return FadeInUp(
          duration: animationDuration,
          child: PastGameListItem(game: games[index]),
        );
      },
    );
  }
}
