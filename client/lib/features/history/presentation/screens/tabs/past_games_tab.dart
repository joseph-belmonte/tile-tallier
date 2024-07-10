import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/past_games_provider.dart';

import '../../widgets/past_game_list.dart';

/// Displays all past games.
class PastGamesTab extends ConsumerWidget {
  // ignore: public_member_api_docs
  const PastGamesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastGamesAsync = ref.watch(pastGamesProvider);

    return pastGamesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('An error occurred while fetching past games.'),
          Center(
            child: Text('Error fetching past games, please try again.'),
          ),
          Divider(),
        ],
      ),
      data: (games) => PastGameList(isFavoriteList: false),
    );
  }
}
