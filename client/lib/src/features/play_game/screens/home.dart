import 'package:flutter/material.dart';

import 'game_history.dart';
import 'pre_game/number_input.dart';
import 'settings/settings.dart';

/// The home page for the Scrabble app.
class HomePage extends StatelessWidget {
  /// Creates a new [HomePage] instance.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME SCREEN'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to Scrabble'),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlayerCountInput()),
              ),
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Play Game'),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GameHistoryPage()),
              ),
              icon: const Icon(Icons.history_edu),
              label: const Text('View History'),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              ),
              icon: const Icon(Icons.settings),
              label: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
