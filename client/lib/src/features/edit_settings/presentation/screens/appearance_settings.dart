import 'package:flutter/material.dart';

/// A page that displays the dark mode settings for the app
class AppearanceSettingsPage extends StatelessWidget {
  /// Creates a new [AppearanceSettingsPage] instance.
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            secondary: const Icon(Icons.dark_mode),
            subtitle: const Text('Enable dark mode'),
            value: true,
            onChanged: (bool value) {
              value = !value;
            },
          ),
          Divider(),
          ListTile(
            title: const Text('Accent Color'),
            subtitle: const Text('Edit the accent color of the app'),
            leading: const Icon(Icons.color_lens),
          ),
          ListTile(
            title: const Text('Red'),
            leading: const Icon(Icons.color_lens),
            trailing: const Icon(Icons.check),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Blue'),
            leading: const Icon(Icons.color_lens),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Yellow'),
            leading: const Icon(Icons.color_lens),
            onTap: () {},
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
