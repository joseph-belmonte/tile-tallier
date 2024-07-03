// ignore: unused_import
import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/edit_settings/presentation/controllers/settings_controller.dart';
import '../features/shared/presentation/screens/home.dart';

import 'controllers/theme_providers.dart';

/// A theming wrapper for the app.
class ThemeWrapper extends ConsumerStatefulWidget {
  /// Default constructor for the theming wrapper.
  const ThemeWrapper({super.key});

  @override
  ConsumerState<ThemeWrapper> createState() => _ThemingAppState();
}

class _ThemingAppState extends ConsumerState<ThemeWrapper> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BetterFeedback(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ref.watch(lightThemeProvider),
        darkTheme: ref.watch(darkThemeProvider),
        themeMode: ref.watch(Settings.themeModeProvider),
        title: 'Scrabble Score Keeper',
        // builder: (context, child) => AccessibilityTools(
        //   checkFontOverflows: true,
        //   child: child,
        // ),
        home: HomePage(),
      ),
    );
  }
}
