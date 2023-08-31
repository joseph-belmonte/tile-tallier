import 'package:flutter/material.dart';

import 'pages/play_history_page.dart';
import 'pages/score_page.dart';
import 'pages/settings_page.dart';

class ScrabbleScorer extends StatelessWidget {
  const ScrabbleScorer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrabble Score Keeper',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 189, 25, 25)),
        useMaterial3: true,
      ),
      home: const SafeArea(
        maintainBottomViewPadding: true,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: TabBar(
              tabs: [
                Tab(text: 'Scores'),
                Tab(text: 'Play History'),
              ],
            ),
            body: TabBarView(
              children: [
                ScorePage(),
                PlayHistoryPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
