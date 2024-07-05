import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../enums/scrabble_edition.dart';
import '../../features/edit_settings/presentation/controllers/settings_controller.dart';

import '../models/app_theme.dart';

/// The light [ThemeData] provider.
///
/// We can use this [Provider] in our [MaterialApp] as a theme. Whenever any
/// of the watched [Settings] providers state is updated, the [MaterialApp]
/// will get new [ThemeData] and be rebuilt with the new theme applied.
final Provider<ThemeData> lightThemeProvider = Provider<ThemeData>(
  (ProviderRef<ThemeData> ref) {
    final isPremium = ref.watch(Settings.isPremiumThemeProvider);
    final premiumTheme = ref.watch(Settings.premiumThemeProvider);

    return AppTheme.light(
      usedTheme: ref.watch(Settings.schemeIndexProvider),
      surfaceMode: ref.watch(Settings.lightSurfaceModeProvider),
      blendLevel: ref.watch(Settings.lightBlendLevelProvider),
      usePrimaryKeyColor: ref.watch(Settings.usePrimaryKeyColorProvider),
      useSecondaryKeyColor: ref.watch(Settings.useSecondaryKeyColorProvider),
      useTertiaryKeyColor: ref.watch(Settings.useTertiaryKeyColorProvider),
      usedFlexTone: ref.watch(Settings.usedFlexToneProvider),
      appBarElevation: ref.watch(Settings.appBarElevationProvider),
      appBarStyle: ref.watch(Settings.lightAppBarStyleProvider),
      appBarOpacity: ref.watch(Settings.lightAppBarOpacityProvider),
      transparentStatusBar: ref.watch(Settings.transparentStatusBarProvider),
      useSubTheme: ref.watch(Settings.useSubThemesProvider),
      defaultRadius: ref.watch(Settings.defaultRadiusProvider),
      isPremiumTheme: isPremium,
      premiumTheme: premiumTheme,
    );
  },
  name: 'lightThemeProvider',
);

/// The dark [ThemeData] provider.
///
/// Same setup as the [lightThemeProvider], we just have a few more properties.
final Provider<ThemeData> darkThemeProvider = Provider<ThemeData>(
  (ProviderRef<ThemeData> ref) {
    final isPremium = ref.watch(Settings.isPremiumThemeProvider);
    final premiumTheme = ref.watch(Settings.premiumThemeProvider);

    return AppTheme.dark(
      usedTheme: ref.watch(Settings.schemeIndexProvider),
      surfaceMode: ref.watch(Settings.darkSurfaceModeProvider),
      blendLevel: ref.watch(Settings.darkBlendLevelProvider),
      usePrimaryKeyColor: ref.watch(Settings.usePrimaryKeyColorProvider),
      useSecondaryKeyColor: ref.watch(Settings.useSecondaryKeyColorProvider),
      useTertiaryKeyColor: ref.watch(Settings.useTertiaryKeyColorProvider),
      usedFlexTone: ref.watch(Settings.usedFlexToneProvider),
      appBarElevation: ref.watch(Settings.appBarElevationProvider),
      appBarStyle: ref.watch(Settings.darkAppBarStyleProvider),
      appBarOpacity: ref.watch(Settings.darkAppBarOpacityProvider),
      transparentStatusBar: ref.watch(Settings.transparentStatusBarProvider),
      darkIsTrueBlack: ref.watch(Settings.darkIsTrueBlackProvider),
      darkLevel: ref.watch(Settings.darkComputeLevelProvider),
      useSubTheme: ref.watch(Settings.useSubThemesProvider),
      defaultRadius: ref.watch(Settings.defaultRadiusProvider),
      isPremiumTheme: isPremium,
      premiumTheme: premiumTheme,
    );
  },
  name: 'darkThemeProvider',
);

/// The [ScrabbleEdition] provider.
final scrabbleEditionProvider =
    StateProvider<ScrabbleEdition>((ref) => ScrabbleEdition.classic);
