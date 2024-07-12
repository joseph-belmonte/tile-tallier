import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/past_games_provider.dart';
import '../../widgets/past_game_list.dart';

/// Displays all favorite games.
class FavoriteGamesTab extends ConsumerWidget {
  /// Creates a new [FavoriteGamesTab] instance.
  const FavoriteGamesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastGamesAsync = ref.watch(pastGamesProvider);

    final favoriteGames =
        pastGamesAsync.where((game) => game.isFavorite).toList();

    if (favoriteGames.isEmpty) {
      return const Center(
        child: Text('No games found.'),
      );
    } else if (favoriteGames.isEmpty) {
      return const Center(
        child: Text('No favorite games found.'),
      );
    }
    return PastGameList(games: favoriteGames);
  }
}
