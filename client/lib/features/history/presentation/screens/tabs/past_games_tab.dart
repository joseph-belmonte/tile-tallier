import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/past_games_provider.dart';

import '../../widgets/past_game_list.dart';

/// Displays all past games.
class PastGamesTab extends ConsumerWidget {
  /// Creates a new [PastGamesTab] instance.
  const PastGamesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final games = ref.watch(pastGamesProvider);

    if (games.isEmpty) {
      return const Center(
        child: Text('No past games found.'),
      );
    }
    games.sort(
      (a, b) => b.plays[0].timestamp
          .toLocal()
          .compareTo(a.plays[0].timestamp.toLocal())
          .toInt(),
    );

    return PastGameList(games: games);
  }
}
