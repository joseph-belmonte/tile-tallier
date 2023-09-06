import 'package:flutter/material.dart';

import 'routes/home_page.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 189, 25, 25),
);
var kLightTheme = ThemeData().copyWith(
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
);
var kDarkTheme = ThemeData.dark().copyWith(
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
);

class MaterialWrapper extends StatelessWidget {
  const MaterialWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrabble Score Keeper',
      themeMode: ThemeMode.system,
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      home: const HomePage(),
    );
  }
}
