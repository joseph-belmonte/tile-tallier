import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/past_games_provider.dart';
import '../../application/providers/players_provider.dart'; // Ensure the path is correct

import '../widgets/deletion_dialog.dart';
import 'tabs/favorite_games_tab.dart';
import 'tabs/past_games_tab.dart';
import 'tabs/players_tab.dart';

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
    Tab(text: 'Past Games'),
    Tab(text: 'Favorites'),
    Tab(text: 'Players'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    // Fetch games when the widget is first built
    Future.microtask(() => ref.read(pastGamesProvider.notifier).fetchGames());
    // Fetch players when the widget is first built
    Future.microtask(() => ref.read(playersProvider.notifier).fetchPlayers());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Deletes all games from the database and updates the state.
  Future<void> deleteAllData() async {
    await ref.read(pastGamesProvider.notifier).deleteAllGames();
    await ref.read(playersProvider.notifier).deleteAllPlayers();
    ref.read(pastGamesProvider.notifier).fetchGames();
    ref.read(playersProvider.notifier).fetchPlayers();
  }

  @override
  Widget build(BuildContext context) {
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
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          PastGamesTab(),
          FavoriteGamesTab(),
          PlayersTab(),
        ],
      ),
    );
  }
}
