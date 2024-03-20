import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'play_history.dart';
import 'play_input.dart';

/// A page that allows the user to input the scores of the players.
class GameNavigator extends ConsumerStatefulWidget {
  /// Creates a new [GameNavigator] instance.
  const GameNavigator({super.key});

  @override
  ConsumerState<GameNavigator> createState() => _GameNavigatorState();
}

class _GameNavigatorState extends ConsumerState<GameNavigator> {
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
            selectedIcon: Icon(Icons.wifi_protected_setup),
            icon: Icon(Icons.wifi_protected_setup),
            label: 'Play Input',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.history),
            icon: Icon(Icons.history),
            label: 'Play History',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: const <Widget>[
          PlayInputPage(),
          PlayHistoryPage(),
        ],
      ),
    );
  }
}
