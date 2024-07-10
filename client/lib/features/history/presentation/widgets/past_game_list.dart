import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/past_games_provider.dart';
import 'past_game_list_item.dart';

/// A list of past games, sorted by date.
class PastGameList extends ConsumerWidget {
  /// Whether this list is displaying favorite games.
  final bool isFavoriteList;

  /// Creates a new [PastGameList] instance.
  const PastGameList({
    this.isFavoriteList = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastGamesAsync = ref.watch(pastGamesProvider);

    return pastGamesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (games) {
        final filteredGames = isFavoriteList
            ? games.where((game) => game.isFavorite).toList()
            : games;

        return ListView.builder(
          itemCount: filteredGames.length,
          itemBuilder: (context, index) {
            return PastGameListItem(
              game: filteredGames[index],
              ref: ref,
            );
          },
        );
      },
    );
  }
}
