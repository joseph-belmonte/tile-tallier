// Custom SubThemesData for each special theme

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// A list of custom, premade themes for the app.
enum DefaultTheme {
  /// A theme inspired by the purple aesthetic.
  purple,

  /// A theme inspired by the Windows 98 aesthetic.
  orange,
}

/// The index of each theme in the [defaultTheme] enum.
const Map<DefaultTheme, int> defaultThemeIndices = {
  DefaultTheme.purple: 0,
  DefaultTheme.orange: 1,
};

/// The color scheme for each premium theme in light mode.
const Map<DefaultTheme, FlexSchemeColor> defaultThemesLight = {
  DefaultTheme.purple: FlexSchemeColor(
    primary: Colors.purple,
    primaryContainer: Colors.purpleAccent,
    secondary: Colors.purple,
    secondaryContainer: Colors.purpleAccent,
    appBarColor: Colors.purple,
  ),
  DefaultTheme.orange: FlexSchemeColor(
    primary: Colors.orange,
    primaryContainer: Colors.orangeAccent,
    secondary: Colors.orange,
    secondaryContainer: Colors.orangeAccent,
    appBarColor: Colors.orange,
  ),
};

/// The color scheme for each premium theme in dark mode.
const Map<DefaultTheme, FlexSchemeColor> defaultThemesDark = {
  DefaultTheme.purple: FlexSchemeColor(
    primary: Colors.purple,
    primaryContainer: Colors.purpleAccent,
    secondary: Colors.purple,
    secondaryContainer: Colors.purpleAccent,
    appBarColor: Colors.purple,
  ),
  DefaultTheme.orange: FlexSchemeColor(
    primary: Colors.orange,
    primaryContainer: Colors.orangeAccent,
    secondary: Colors.orange,
    secondaryContainer: Colors.orangeAccent,
    appBarColor: Colors.orange,
  ),
};

/// The sub-theme data for each premium theme.
final Map<DefaultTheme, FlexSubThemesData> defaultThemeSubThemes = {
  DefaultTheme.purple: FlexSubThemesData(),
  DefaultTheme.orange: FlexSubThemesData(),
};

/// The typography for each premium theme.
final Map<DefaultTheme, Typography> defaultThemeTypography = {
  DefaultTheme.purple: Typography.material2021(),
  DefaultTheme.orange: Typography.material2021(),
};
