import 'package:flutter/material.dart';

import 'pages/play_history_page.dart';
import 'pages/score_page.dart';
import 'pages/settings_page.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 189, 25, 25),
);

class ScrabbleScorer extends StatelessWidget {
  const ScrabbleScorer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrabble Score Keeper',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          foregroundColor: kColorScheme.onPrimaryContainer,
          backgroundColor: kColorScheme.primaryContainer,
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: ThemeData().textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 36,
                  ),
              titleMedium: ThemeData().textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 24,
                  ),
              titleSmall: ThemeData().textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 18,
                  ),
              bodyLarge: ThemeData().textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 24,
                  ),
              bodyMedium: ThemeData().textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 18,
                  ),
              bodySmall: ThemeData().textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 14,
                  ),
            ),
      ),
      home: const SafeArea(
        maintainBottomViewPadding: true,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: TabBar(
              tabs: [
                Tab(text: 'Scores'),
                Tab(text: 'Play History'),
                Tab(text: 'Settings'),
              ],
            ),
            body: TabBarView(
              children: [
                ScorePage(),
                PlayHistoryPage(),
                SettingsPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
