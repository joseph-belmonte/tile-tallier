import 'package:flutter/material.dart';

import 'keyboard.dart';
import 'models/game.dart';

class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  /// Sets the theme mode and notifies listeners.
  set themeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  ScrabbleEdition _edition = ScrabbleEdition.classic;
  ScrabbleEdition get edition => _edition;

  /// Sets the edition and notifies listeners.
  set edition(ScrabbleEdition value) {
    _edition = value;
    notifyListeners();
  }

  KeyboardType _keyboardType = KeyboardType.button;
  KeyboardType get keyboardType => _keyboardType;

  /// Sets the keyboard type and notifies listeners.
  set keyboardType(KeyboardType value) {
    _keyboardType = value;
    notifyListeners();
  }
}
