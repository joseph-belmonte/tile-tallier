import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/game.dart';
import '../../application/providers/past_games_provider.dart';
import '../widgets/deletion_dialog.dart';
import '../widgets/past_game_list.dart';

/// A page that displays the past games.
class PastGamesPage extends ConsumerStatefulWidget {
  /// Creates a new [PastGamesPage] instance.
  const PastGamesPage({super.key});

  @override
  ConsumerState<PastGamesPage> createState() => _PastGamesPageState();
}

class _PastGamesPageState extends ConsumerState<PastGamesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Past Games'),
    Tab(text: 'Favorite Games'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    // Fetch games when the widget is first built
    Future.microtask(() => ref.read(pastGamesProvider.notifier).fetchGames());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pastGamesAsync = ref.watch(pastGamesProvider);

    /// Deletes all games from the database and updates the state.
    void deletePastGames() async {
      await ref.read(pastGamesProvider.notifier).deleteAllGames();
      ref.read(pastGamesProvider.notifier).fetchGames();
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game History'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDeletionDialog(
                context,
                onConfirm: deletePastGames,
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: pastGamesAsync.when(
        skipLoadingOnRefresh: true,
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stack) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('An error occurred while fetching past games.'),
              Center(
                child: Text('Error fetching past games, please try again.'),
              ),
              Divider(),
            ],
          );
        },
        data: (List<Game> games) {
          return Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    PastGameList(games, context, ref),
                    games.any((game) => game.isFavorite)
                        ? PastGameList(
                            games,
                            context,
                            ref,
                            isFavoriteList: true,
                          )
                        : const Center(
                            child: Text('No favorite games yet.'),
                          ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
