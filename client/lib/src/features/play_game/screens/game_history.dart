import 'package:flutter/material.dart';

/// A page that displays the game history
class GameHistoryPage extends StatelessWidget {
  /// Creates a new [GameHistoryPage] instance.
  const GameHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GAME HISTORY SCREEN'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('You can view previous games here'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
