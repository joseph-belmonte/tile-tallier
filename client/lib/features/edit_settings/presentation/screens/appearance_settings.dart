import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/color_screen.dart';
import '../widgets/theme_mode_toggle_buttons.dart';

/// A page that displays the dark mode settings for the app
class AppearanceSettingsPage extends ConsumerWidget {
  /// Creates a new [AppearanceSettingsPage] instance.
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            leading: const Icon(Icons.dark_mode),
            subtitle: const Text('Edit Dark Mode'),
            trailing: ThemeModeToggleButtons(),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: AboutListTile(
              icon: const Icon(Icons.info),
              applicationName: 'Scrabble Score Keeper',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2024',
              aboutBoxChildren: const <Widget>[
                SizedBox(height: 24),
                Text('made with ❤️ in pgh'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
