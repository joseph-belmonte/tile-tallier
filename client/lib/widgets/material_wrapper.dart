import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../routes/home.dart';

class MaterialWrapper extends StatelessWidget {
  const MaterialWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (_, appState, __) => buildAppWrapper(appState));
  }

  Widget buildAppWrapper(AppState appState) {
    var ThemeBuilder(:lightTheme, :darkTheme) = ThemeBuilder(appState.colorScheme);
    return MaterialApp(
      locale: const Locale('en'),
      title: 'Scrabble Score Keeper',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: appState.themeMode,
      home: const HomePage(),
    );
  }
}

class ThemeBuilder {
  final ColorScheme colorScheme;
  late final ThemeData lightTheme;
  late final ThemeData darkTheme;

  ThemeBuilder(this.colorScheme) {
    darkTheme = _buildDarkTheme();
    lightTheme = _buildLightTheme();
  }

  ThemeData _buildDarkTheme() {
    ThemeData theme = ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: colorScheme,
    );
    return theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        titleLarge: _standardizeTextStyle(baseStyle: theme.textTheme.titleLarge!, fontSize: 36),
        titleMedium: _standardizeTextStyle(baseStyle: theme.textTheme.titleMedium!, fontSize: 24),
        titleSmall: _standardizeTextStyle(baseStyle: theme.textTheme.titleSmall!, fontSize: 18),
        bodyLarge: _standardizeTextStyle(baseStyle: theme.textTheme.bodyLarge!, fontSize: 24),
        bodyMedium: _standardizeTextStyle(baseStyle: theme.textTheme.bodyMedium!, fontSize: 18),
        bodySmall: _standardizeTextStyle(baseStyle: theme.textTheme.bodySmall!, fontSize: 14),
      ),
    );
  }

  ThemeData _buildLightTheme() {
    ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
    );
    return theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        titleLarge: _standardizeTextStyle(baseStyle: theme.textTheme.titleLarge!, fontSize: 36),
        titleMedium: _standardizeTextStyle(baseStyle: theme.textTheme.titleMedium!, fontSize: 24),
        titleSmall: _standardizeTextStyle(baseStyle: theme.textTheme.titleSmall!, fontSize: 18),
        bodyLarge: _standardizeTextStyle(baseStyle: theme.textTheme.bodyLarge!, fontSize: 24),
        bodyMedium: _standardizeTextStyle(baseStyle: theme.textTheme.bodyMedium!, fontSize: 18),
        bodySmall: _standardizeTextStyle(baseStyle: theme.textTheme.bodySmall!, fontSize: 14),
      ),
    );
  }

  TextStyle _standardizeTextStyle({required TextStyle baseStyle, required double fontSize}) {
    return baseStyle.copyWith(
      fontWeight: FontWeight.normal,
      fontSize: fontSize,
    );
  }
}
