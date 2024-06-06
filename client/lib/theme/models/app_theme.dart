// ignore_for_file: unused_local_variable

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../constants/default_themes.dart';
import '../constants/premium_themes.dart';
import 'flex_tone.dart';

/// The themes for this app are defined here.
class AppTheme {
  // This constructor prevents external instantiation and extension.
  AppTheme._();

  /// Returns light theme based on required parameters passed to it.
  ///
  /// Note:
  /// We could do this directly in the Riverpod Provider too, this
  /// is an extra step to wrap the FlexColorScheme usage. In case we want
  /// to use just plain ThemeData we can replace FlexColorScheme usage here.
  static ThemeData light({
    required int usedTheme, // this is the index in your complete list of themes
    required FlexSurfaceMode surfaceMode,
    required int blendLevel,
    //
    required bool usePrimaryKeyColor,
    required bool useSecondaryKeyColor,
    required bool useTertiaryKeyColor,
    required int usedFlexTone,
    //
    required double appBarElevation,
    required FlexAppBarStyle? appBarStyle,
    required double appBarOpacity,
    required bool transparentStatusBar,
    //
    required bool useSubTheme,
    required double? defaultRadius,
    required bool isPremiumTheme,
    PremiumTheme? premiumTheme,
  }) {
    FlexSubThemesData? subThemesData;
    Typography? typography;

    if (isPremiumTheme && premiumTheme != null) {
      // In case we have a premium theme selected, we use the premium theme data
      subThemesData = premiumThemeSubThemes[premiumTheme];
      typography = premiumThemeTypography[premiumTheme];
    }

    return FlexThemeData.light(
      useMaterial3: true,
      colors: isPremiumTheme && premiumTheme != null
          ? premiumThemesLight[premiumTheme]!
          : schemes[usedTheme].light,
      surfaceMode: surfaceMode,
      blendLevel: blendLevel,
      //
      keyColors: FlexKeyColors(
        useKeyColors: usePrimaryKeyColor,
        useSecondary: useSecondaryKeyColor,
        useTertiary: useTertiaryKeyColor,
      ),
      tones: FlexTone.values[usedFlexTone].tones(Brightness.light),
      //
      appBarElevation: appBarElevation,
      appBarStyle: appBarStyle,
      appBarOpacity: appBarOpacity,
      transparentStatusBar: transparentStatusBar,
      //
      subThemesData: subThemesData ??
          (useSubTheme
              ? FlexSubThemesData(
                  defaultRadius: defaultRadius,
                  thinBorderWidth: 1,
                  thickBorderWidth: 2,
                )
              : null),
      //
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      typography: typography ?? Typography.material2021(),
    );
  }

  /// Returns dark theme based on required parameters passed to it.
  ///
  /// Note:
  /// We could do this directly in the Riverpod Provider too, this
  /// is an extra step to wrap the FlexColorScheme usage. In case we want
  /// to use just plain ThemeData we can replace FlexColorScheme usage here.
  static ThemeData dark({
    required int usedTheme,
    required FlexSurfaceMode surfaceMode,
    required int blendLevel,
    //
    required bool usePrimaryKeyColor,
    required bool useSecondaryKeyColor,
    required bool useTertiaryKeyColor,
    required int usedFlexTone,
    //
    required double appBarElevation,
    required FlexAppBarStyle? appBarStyle,
    required double appBarOpacity,
    required bool transparentStatusBar,
    //
    required int darkLevel,
    required bool darkIsTrueBlack,
    //
    required bool useSubTheme,
    required double? defaultRadius,
    required bool isPremiumTheme,
    PremiumTheme? premiumTheme,
  }) {
    FlexSubThemesData? subThemesData;
    Typography? typography;

    if (isPremiumTheme && premiumTheme != null) {
      subThemesData = premiumThemeSubThemes[premiumTheme];
      typography = premiumThemeTypography[premiumTheme];
    }
    return FlexThemeData.dark(
      useMaterial3: true,
      surfaceMode: surfaceMode,
      blendLevel: blendLevel,
      //
      colors: isPremiumTheme && premiumTheme != null
          ? premiumThemesDark[premiumTheme]!
          : schemes[usedTheme].dark,
      keyColors: FlexKeyColors(
        useKeyColors: usePrimaryKeyColor,
        useSecondary: useSecondaryKeyColor,
        useTertiary: useTertiaryKeyColor,
      ),
      tones: FlexTone.values[usedFlexTone].tones(Brightness.dark),
      //
      appBarElevation: appBarElevation,
      appBarStyle: appBarStyle,
      appBarOpacity: appBarOpacity,
      transparentStatusBar: transparentStatusBar,
      //
      darkIsTrueBlack: darkIsTrueBlack,
      //
      subThemesData: subThemesData ??
          (useSubTheme
              ? FlexSubThemesData(
                  defaultRadius: defaultRadius,
                  thinBorderWidth: 1,
                  thickBorderWidth: 2,
                )
              : null),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      typography: typography ?? Typography.material2021(),
    );
  }

  // We could also use the FlexSchemeColor.from() constructor and define less
  // color properties and get many of the values below computed by the
  // `from` factory. If we do that, then custom `FlexSchemeColor`s below cannot
  // be const, nor the `schemes` list below, but otherwise it
  // works the same. In this demo we specify all required colors and do not
  // use the convenience features offered by the FlexSchemeColor.from() factory.
  // Well yes I did at first, but then I copy-pasted the values it computed for
  // the values I did not want to specify. Copied from the theme_demo app UI,
  // by just clicking on each color box in the UI to get the Flutter color code
  // for it and then added the colors as const values below instead :)

  /// A list of default themes for the app.
  static List<FlexSchemeData> defaultSchemes = <FlexSchemeData>[
    FlexSchemeData(
      name: 'Hazy sun',
      description: 'If you need Vitamin C',
      light: defaultThemesLight[DefaultTheme.orange]!,
      dark: defaultThemesDark[DefaultTheme.orange]!,
    ),
    FlexSchemeData(
      name: 'Purple rain',
      description: 'For a purple rain',
      light: defaultThemesLight[DefaultTheme.purple]!,
      dark: defaultThemesDark[DefaultTheme.purple]!,
    ),
  ];

  /// A list of custom, premium schemes for the app.
  static List<FlexSchemeData> premiumSchemes = <FlexSchemeData>[
    FlexSchemeData(
      name: 'Vaporwave',
      description: 'For a colorful and fun look',
      light: premiumThemesLight[PremiumTheme.vaporwave]!,
      dark: premiumThemesDark[PremiumTheme.vaporwave]!,
    ),
    FlexSchemeData(
      name: 'Windows 95',
      description: 'For a 1995 feeling',
      light: premiumThemesLight[PremiumTheme.windows98]!,
      dark: premiumThemesDark[PremiumTheme.windows98]!,
    ),
  ];

  /// Create a list with all our custom color schemes and add
  /// all the FlexColorScheme built-in ones to the end of the list.
  static List<FlexSchemeData> schemes = <FlexSchemeData>[
    ...defaultSchemes,
    // Reference of adding a custom scheme:
    ...premiumSchemes,
  ];
}
