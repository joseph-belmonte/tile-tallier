import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/edit_settings/application/providers/drawer_width_provider.dart';
import '../features/edit_settings/presentation/controllers/settings.dart';
import '../features/play_game/presentation/screens/home.dart';
import '../utils/drawer_width.dart';
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
  void didChangeMetrics() {
    ref.read(drawerWidthProvider.notifier).state = drawerWidth();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ref.watch(lightThemeProvider),
      darkTheme: ref.watch(darkThemeProvider),
      themeMode: ref.watch(Settings.themeModeProvider),
      title: 'Scrabble Score Keeper',
      home: const HomePage(),
    );
  }
}
