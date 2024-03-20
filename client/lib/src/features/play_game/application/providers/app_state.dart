import 'package:flutter/material.dart';

import '../../../../../enums/scrabble_edition.dart';

/// A class that holds the state of the app.
class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  /// The current theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Sets the theme mode and notifies listeners.
  set themeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  ScrabbleEdition _edition = ScrabbleEdition.classic;

  /// The current Scrabble edition.
  ScrabbleEdition get edition => _edition;

  /// Sets the edition and notifies listeners.
  set edition(ScrabbleEdition value) {
    _edition = value;
    notifyListeners();
  }

  /// The current color scheme.
  ColorScheme get colorScheme {
    return ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 163, 26, 39));
  }
}
