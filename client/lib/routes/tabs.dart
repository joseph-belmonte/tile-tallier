import 'package:flutter/material.dart';

import 'play_history_page.dart';
import 'game_page.dart';
import 'settings_page.dart';

/// Displays the active game page, play history page, and settings page in a tab
///  view.
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Theme.of(context).colorScheme.primary,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Game',
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'Play History',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        GamePage(),
        PlayHistoryPage(),
        SettingsPage(),
      ][currentPageIndex],
    );
  }
}
