import 'package:flutter/material.dart';

class GameHistoryPage extends StatelessWidget {
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
            Placeholder(
              fallbackHeight: 100,
              fallbackWidth: 100,
            ),
          ],
        ),
      ),
    );
  }
}
