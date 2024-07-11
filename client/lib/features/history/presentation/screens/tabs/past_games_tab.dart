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
    final pastGamesAsync = ref.watch(pastGamesProvider);

    return pastGamesAsync.when(
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Text('An error occurred while fetching past games.'),
          Center(
            child: Text('Error fetching past games, please try again.'),
          ),
          Divider(),
        ],
      ),
      data: (games) => PastGameList(games: games),
    );
  }
}
