import 'package:flutter/material.dart';

import '../../../edit_settings/presentation/screens/settings.dart';
import '../../../play_game/presentation/screens/pre_game/number_input.dart';
import '../../../view_past_games/presentation/screens/game_history.dart';

/// The home page for the Scrabble app.
class HomePage extends StatelessWidget {
  /// Creates a new [HomePage] instance.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scrabble Scorer',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlayerCountInput()),
              ),
              icon: Icon(Icons.play_arrow_rounded),
              label: Text('Play Game'),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GameHistoryPage()),
              ),
              icon: Icon(Icons.history_edu),
              label: Text('View History'),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              ),
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
