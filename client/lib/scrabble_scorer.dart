import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/play_history_page.dart';
import 'routes/score_page.dart';
import 'routes/settings_page.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 189, 25, 25),
);

class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  set themeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }
}

class ScrabbleScorer extends StatelessWidget {
  const ScrabbleScorer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
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
                        color: kColorScheme.onPrimary,
                        fontSize: 36,
                      ),
                  titleMedium: ThemeData().textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: kColorScheme.onPrimary,
                        fontSize: 24,
                      ),
                  titleSmall: ThemeData().textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: kColorScheme.onPrimary,
                        fontSize: 18,
                      ),
                  bodyLarge: ThemeData().textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: kColorScheme.onPrimary,
                        fontSize: 24,
                      ),
                  bodyMedium: ThemeData().textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: kColorScheme.onPrimary,
                        fontSize: 18,
                      ),
                  bodySmall: ThemeData().textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: kColorScheme.onPrimary,
                        fontSize: 14,
                      ),
                ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            useMaterial3: true,
            colorScheme: kColorScheme,
            appBarTheme: AppBarTheme().copyWith(
              foregroundColor: kColorScheme.onPrimaryContainer,
              backgroundColor: kColorScheme.primaryContainer,
            ),
            textTheme: ThemeData.dark().textTheme.copyWith(
                  titleLarge: ThemeData.dark().textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: kColorScheme.onPrimary,
                        fontSize: 36,
                      ),
                  titleMedium: ThemeData.dark().textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: kColorScheme.onPrimary,
                        fontSize: 24,
                      ),
                  titleSmall: ThemeData.dark().textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: kColorScheme.onPrimary,
                        fontSize: 18,
                      ),
                  bodyLarge: ThemeData.dark().textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: kColorScheme.onPrimary,
                        fontSize: 24,
                      ),
                  bodyMedium: ThemeData.dark().textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: kColorScheme.onPrimary,
                        fontSize: 18,
                      ),
                  bodySmall: ThemeData.dark().textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: kColorScheme.onPrimary,
                        fontSize: 14,
                      ),
                ),
          ),
          themeMode: appState.themeMode,
          home: SafeArea(
            maintainBottomViewPadding: true,
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'Scores',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Play History',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Settings',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                body: TabBarView(
                  children: const [
                    ScorePage(),
                    PlayHistoryPage(),
                    SettingsPage(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
