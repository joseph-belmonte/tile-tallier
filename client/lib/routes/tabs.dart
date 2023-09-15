import 'package:flutter/material.dart';

import 'play_history_page.dart';
import 'play_input_page.dart';
import 'settings_page.dart';

/// Displays the active game page, play history page, and settings page in a tab
/// view.
class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
