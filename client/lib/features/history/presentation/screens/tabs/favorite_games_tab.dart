import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/models/game.dart';
import '../../../application/providers/past_games_provider.dart';
import '../../widgets/past_game_list.dart';

/// Displays all favorite games.
class FavoriteGamesTab extends ConsumerWidget {
  /// Creates a new [FavoriteGamesTab] instance.
  const FavoriteGamesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastGamesAsync = ref.watch(pastGamesProvider);

    return pastGamesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Center(
            child: Text('Error fetching favorite games, please try again.'),
          ),
        ],
      ),
      data: (List<Game> games) {
        final favoriteGames = games.where((game) => game.isFavorite).toList();
        if (games.isEmpty) {
          return const Center(
            child: Text('No games found.'),
          );
        } else if (favoriteGames.isEmpty) {
          return const Center(
            child: Text('No favorite games found.'),
          );
        }
        return PastGameList(games: favoriteGames);
      },
    );
  }
}
