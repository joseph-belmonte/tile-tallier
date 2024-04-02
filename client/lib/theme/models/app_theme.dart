import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

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
    required bool useMaterial3,
    required int usedTheme,
    required bool swapColors,
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
  }) {
    // In case we need to use the ColorScheme defined by defined FlexColorScheme
    // as input to a custom sub-theme, we can make the FCS object and get the
    // ColorS
    final flexScheme = FlexColorScheme.light(
      useMaterial3: useMaterial3,
      colors: schemes[usedTheme].light,
      swapColors: swapColors,
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
      subThemesData: useSubTheme
          ? FlexSubThemesData(
              defaultRadius: defaultRadius,
              thinBorderWidth: 1,
              thickBorderWidth: 2,
            )
          : null,
      //
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      typography: Typography.material2021(),
    );

    // If we need any colors from the ColorScheme resulting from above
    // FlexColorScheme, we can now extract it with:
    //
    // ColorScheme scheme = flexScheme.toScheme;
    //
    // And then use its colors in any custom component themes on the `toTheme`
    // below using `copyWith` on the resulting `ThemeData`. We can do this to
    // make a copy of it and add features not covered by FlexColorScheme. We are
    // not doing that in this demo, this is just a mention of how to do it.
    // How to do this is a frequently asked question, see here for more info:
    // https://github.com/rydmike/flex_color_scheme/discussions/92

    // Convert above FlexColorScheme to ThemeData and return it.
    return flexScheme.toTheme;
  }

  /// Returns dark theme based on required parameters passed to it.
  ///
  /// Note:
  /// We could do this directly in the Riverpod Provider too, this
  /// is an extra step to wrap the FlexColorScheme usage. In case we want
  /// to use just plain ThemeData we can replace FlexColorScheme usage here.
  static ThemeData dark({
    required bool useMaterial3,
    required int usedTheme,
    required bool swapColors,
    required FlexSurfaceMode surfaceMode,
    required int blendLevel,
    required bool usePrimaryKeyColor,
    required bool useSecondaryKeyColor,
    required bool useTertiaryKeyColor,
    required int usedFlexTone,
    //
    required double appBarElevation,
    required FlexAppBarStyle? appBarStyle,
    required double appBarOpacity,
    required bool transparentStatusBar,
    required bool computeDark,
    required int darkLevel,
    required bool darkIsTrueBlack,
    required bool useSubTheme,
    required double? defaultRadius,
  }) {
    // As in the `light` theme function mentioned, we do not need the produced
    // ColorScheme for further custom sub-theming here. We can thus use the more
    // commonly used and more familiar looking extension syntax
    // FlexThemeData.dark and return it directly. Above we could of could have
    // used the equivalent FlexThemeData.light version, but for educational
    // purposes the step using the `FlexColorScheme.light` API with the
    // `toTheme` method was demonstrated.
    return FlexThemeData.dark(
      useMaterial3: useMaterial3,
      colors: computeDark
          // Option to compute the dark theme from the light theme colors.
          // This is handy if we have only defined light theme colors and
          // want to compute a dark scheme from them. It is a bit like `seed`
          // generated M3 scheme, but it is only based on white color alpha
          // blend to de-saturate the light theme colors an adjustable amount.
          // In this demo we have dark theme color definitions for all themes,
          // this is only included to demonstrate the feature.
          ? schemes[usedTheme].light.defaultError.toDark(darkLevel, useMaterial3)
          : schemes[usedTheme].dark,
      swapColors: swapColors,
      surfaceMode: surfaceMode,
      blendLevel: blendLevel,
      //
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
      subThemesData: useSubTheme
          ? FlexSubThemesData(
              defaultRadius: defaultRadius,
              thinBorderWidth: 1,
              thickBorderWidth: 2,
            )
          : null,
      //
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      typography: Typography.material2021(),
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

  /// Create a list with all our custom color schemes and add
  /// all the FlexColorScheme built-in ones to the end of the list.
  static const List<FlexSchemeData> schemes = <FlexSchemeData>[
    // Reference of adding a custom scheme:
    // FlexSchemeData(
    //   name: 'Juan and pink',
    //   description: 'San Juan blue and sea pink.',
    //   light: _customScheme2Light,
    //   dark: _customScheme2Dark,
    // ),

    // After all our custom color schemes, and hand picked built-in schemes
    // we add all built-in FlexColor schemes. The MandyRed scheme will of
    // course show up as a duplicate when we do this, since we added it manually
    // already. This is just to demonstrate how to easily add all existing
    // scheme to end of our custom scheme choices.
    ...FlexColor.schemesList,
  ];
}
