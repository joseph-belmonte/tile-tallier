import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/settings.dart';
import '../screens/color_screen.dart';
import '../widgets/app_about_tile.dart';

/// A page that displays the dark mode settings for the app
class AppearanceSettingsPage extends ConsumerWidget {
  /// Creates a new [AppearanceSettingsPage] instance.
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(Settings.themeModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Brightness'),
            leading: const Icon(Icons.brightness_4),
            subtitle: const Text('Edit display brightness settings'),
          ),
          ListTile(
            title: const Text('System Mode'),
            leading: const Icon(Icons.phone_android),
            trailing: themeMode.index == 0 ? const Icon(Icons.check) : null,
            onTap: () => ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.system),
          ),
          ListTile(
            title: const Text('Light Mode'),
            leading: const Icon(Icons.light_mode),
            trailing: themeMode.index == 1 ? const Icon(Icons.check) : null,
            onTap: () => ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.light),
          ),
          ListTile(
            title: const Text('Dark Mode'),
            leading: const Icon(Icons.dark_mode),
            trailing: themeMode.index == 2 ? const Icon(Icons.check) : null,
            onTap: () => ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.dark),
          ),
          Divider(),
          ListTile(
            title: const Text('Primary Color'),
            subtitle: const Text('Edit the primary color of the app'),
            leading: const Icon(Icons.color_lens),
            trailing: const Icon(Icons.arrow_forward_sharp),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ColorScreen(),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: const Text('Scrabble edition'),
            subtitle: const Text('Edit the display of tiles'),
            leading: const Icon(Icons.format_color_text),
          ),
          ListTile(
            title: const Text('Classic'),
            leading: const Icon(Icons.format_color_text),
            trailing: const Icon(Icons.check),
            onTap: () {},
          ),
          ListTile(
            title: const Text('25th Anniversary'),
            leading: const Icon(Icons.format_color_text),
            onTap: () {},
          ),
          Divider(),
          AppAboutTile(),
        ],
      ),
    );
  }
}
