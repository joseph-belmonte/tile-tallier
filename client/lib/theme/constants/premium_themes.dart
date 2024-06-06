// Custom SubThemesData for each special theme

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// A list of custom, premade themes for the app.
enum PremiumTheme {
  /// A theme inspired by the vaporwave aesthetic.
  vaporwave,

  /// A theme inspired by the Windows 98 aesthetic.
  windows98,
}

/// The index of each theme in the [PremiumTheme] enum.
const Map<PremiumTheme, int> premiumThemeIndices = {
  PremiumTheme.vaporwave: 0,
  PremiumTheme.windows98: 1,
};

/// The color scheme for each premium theme in light mode.
const Map<PremiumTheme, FlexSchemeColor> premiumThemesLight = {
  PremiumTheme.vaporwave: FlexSchemeColor(
    primary: Color(0xFF49709B),
    primaryContainer: Color(0xFF7995B3),
    secondary: Color(0xFF8096B1),
    secondaryContainer: Color(0xFF395778),
    tertiary: Color(0xFFA0B0C4),
    tertiaryContainer: Color(0xFFC9D5E3),
    appBarColor: Color(0xFF8096B1),
  ),
  PremiumTheme.windows98: FlexSchemeColor(
    primary: Color(0xFF008080),
    primaryContainer: Color(0xFF00FFFF),
    secondary: Color(0xFF800080),
    secondaryContainer: Color(0xFFFF00FF),
    appBarColor: Color(0xFF008080),
  ),
};

/// The color scheme for each premium theme in dark mode.
const Map<PremiumTheme, FlexSchemeColor> premiumThemesDark = {
  PremiumTheme.vaporwave: FlexSchemeColor(
    primary: Color(0xFF30506D),
    primaryContainer: Color(0xFF526D85),
    secondary: Color(0xFF53677F),
    secondaryContainer: Color(0xFF2E3D4F),
    tertiary: Color(0xFF75899C),
    tertiaryContainer: Color(0xFF8FABC4),
    appBarColor: Color(0xFF4E6A88),
  ),
  PremiumTheme.windows98: FlexSchemeColor(
    primary: Color(0xFF008080),
    primaryContainer: Color(0xFF00FFFF),
    secondary: Color(0xFF800080),
    secondaryContainer: Color(0xFFFF00FF),
    appBarColor: Color(0xFF008080),
  ),
};

/// The sub-theme data for each premium theme.
final Map<PremiumTheme, FlexSubThemesData> premiumThemeSubThemes = {
  PremiumTheme.vaporwave: FlexSubThemesData(
    defaultRadius: 20.0,
    thinBorderWidth: 2,
    thickBorderWidth: 3,
  ),
  PremiumTheme.windows98: FlexSubThemesData(
    defaultRadius: 0.0,
    thinBorderWidth: 1,
    thickBorderWidth: 2,
  ),
};

/// The typography for each premium theme.
final Map<PremiumTheme, Typography> premiumThemeTypography = {
  PremiumTheme.vaporwave: Typography.material2021().copyWith(),
  PremiumTheme.windows98: Typography.material2021().copyWith(
    black: TextTheme(
      displayLarge: TextStyle(fontFamily: 'W95FA', fontSize: 96, color: Colors.black),
      displayMedium: TextStyle(fontFamily: 'W95FA', fontSize: 60, color: Colors.black),
      displaySmall: TextStyle(fontFamily: 'W95FA', fontSize: 48, color: Colors.black),
      titleLarge: TextStyle(fontFamily: 'W95FA', fontSize: 24, color: Colors.black),
      titleMedium: TextStyle(fontFamily: 'W95FA', fontSize: 20, color: Colors.black),
      titleSmall: TextStyle(fontFamily: 'W95FA', fontSize: 16, color: Colors.black),
      bodyLarge: TextStyle(fontFamily: 'W95FA', fontSize: 14, color: Colors.black),
      bodyMedium: TextStyle(fontFamily: 'W95FA', fontSize: 12, color: Colors.black),
      bodySmall: TextStyle(fontFamily: 'W95FA', fontSize: 10, color: Colors.black),
      labelLarge: TextStyle(fontFamily: 'W95FA', fontSize: 14, color: Colors.black),
      labelMedium: TextStyle(fontFamily: 'W95FA', fontSize: 12, color: Colors.black),
      labelSmall: TextStyle(fontFamily: 'W95FA', fontSize: 10, color: Colors.black),
    ),
    white: TextTheme(
      displayLarge: TextStyle(fontFamily: 'W95FA', fontSize: 96, color: Colors.white),
      displayMedium: TextStyle(fontFamily: 'W95FA', fontSize: 60, color: Colors.white),
      displaySmall: TextStyle(fontFamily: 'W95FA', fontSize: 48, color: Colors.white),
      titleLarge: TextStyle(fontFamily: 'W95FA', fontSize: 24, color: Colors.white),
      titleMedium: TextStyle(fontFamily: 'W95FA', fontSize: 20, color: Colors.white),
      titleSmall: TextStyle(fontFamily: 'W95FA', fontSize: 16, color: Colors.white),
      bodyLarge: TextStyle(fontFamily: 'W95FA', fontSize: 14, color: Colors.white),
      bodyMedium: TextStyle(fontFamily: 'W95FA', fontSize: 12, color: Colors.white),
      bodySmall: TextStyle(fontFamily: 'W95FA', fontSize: 10, color: Colors.white),
      labelLarge: TextStyle(fontFamily: 'W95FA', fontSize: 14, color: Colors.white),
      labelMedium: TextStyle(fontFamily: 'W95FA', fontSize: 12, color: Colors.white),
      labelSmall: TextStyle(fontFamily: 'W95FA', fontSize: 10, color: Colors.white),
    ),
  ),
};
