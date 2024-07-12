import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/history_page_controller.dart';
import '../widgets/deletion_dialog.dart';
import 'tabs/favorite_games_tab.dart';
import 'tabs/past_games_tab.dart';
import 'tabs/players_tab.dart';

// TODO: write tests for methods involving the database and history feature
// - note that when updating a player name, the player name should be updated in the database
// for every game that the player has played

/// A page that displays past games, favorite games, and players.
class HistoryPage extends ConsumerStatefulWidget {
  /// Creates a new [HistoryPage] instance.
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'All Games'),
    Tab(text: 'Favorites'),
    Tab(text: 'Players'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    Future.microtask(() {
      ref.read(historyPageControllerProvider.notifier).fetchGames();
      ref.read(historyPageControllerProvider.notifier).fetchPlayers();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Deletes all games from the database and updates the state.
  Future<void> deleteAllData() async {
    await ref.read(historyPageControllerProvider.notifier).deleteAllGames();
    await ref.read(historyPageControllerProvider.notifier).deleteAllPlayers();
    await ref.read(historyPageControllerProvider.notifier).fetchGames();
    await ref.read(historyPageControllerProvider.notifier).fetchPlayers();
  }

  @override
  Widget build(BuildContext context) {
    final historyPageState = ref.watch(historyPageControllerProvider);

    Widget content;

    if (historyPageState.isLoading) {
      content = Center(child: CircularProgressIndicator());
    }

    if (historyPageState.errorMessage != null) {
      content = Center(child: Text('Error: ${historyPageState.errorMessage}'));
    } else {
      content = TabBarView(
        controller: _tabController,
        children: const <Widget>[
          PastGamesTab(),
          FavoriteGamesTab(),
          PlayersTab(),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDeletionDialog(
                context,
                onConfirm: deleteAllData,
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: content,
    );
  }
}
