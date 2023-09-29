import 'package:flutter/material.dart';

import 'game_history.dart';
import 'game_start/number_input.dart';

class HomePage extends StatelessWidget {
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
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GameHistoryPage()),
              ),
              icon: const Icon(Icons.history_edu),
              label: const Text('View History'),
            ),
          ],
        ),
      ),
    );
  }
}
