import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/active_game.dart';
import '../providers/active_play.dart';
import './play_history.dart';
import 'play_input.dart';
import 'settings.dart';

/// Displays the active game page, play history page, and settings page in a tab
/// view.
class GameView extends StatefulWidget {
  final List<String> playerList;
  const GameView({required this.playerList, super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ActiveGame>(
          create: (context) => ActiveGame(playerNames: widget.playerList),
        ),
        ChangeNotifierProvider<ActivePlay>(
          create: (context) {
            var game = Provider.of<ActiveGame>(context, listen: false);
            var activePlay = ActivePlay();
            activePlay.play = game.activeGame.currentPlay;
            return activePlay;
          },
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) => setState(() => currentPageIndex = index),
          indicatorColor: Theme.of(context).colorScheme.primary,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.wifi_protected_setup),
              icon: Icon(Icons.wifi_protected_setup),
              label: 'Play Input',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.history),
              icon: Icon(Icons.history),
              label: 'Play History',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        body: <Widget>[
          PlayInputPage(),
          PlayHistoryPage(),
          SettingsPage(),
        ][currentPageIndex],
      ),
    );
  }
}
