import 'package:flutter/material.dart';
import 'package:scrabble_scorer/routes/game_history_page.dart';
import 'package:scrabble_scorer/routes/tabs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME SCREEN'),
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
                MaterialPageRoute(
                  builder: (context) => const BottomNavBar(),
                ),
              ),
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Start Game'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GameHistoryPage(),
                ),
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
