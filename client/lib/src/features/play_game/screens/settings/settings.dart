import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import 'dark_mode_settings.dart';
import 'scarbble_edition_settings.dart';

/// A page that displays the settings for the app
class SettingsPage extends StatelessWidget {
  /// Creates a new [SettingsPage] instance.
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Appearance'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.nightlight),
                title: Text('Dark Mode'),
                trailing: Row(
                  children: const [
                    Icon(Icons.navigate_next),
                  ],
                ),
                onPressed: (context) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DarkModeSettingsPage(),
                  ),
                ),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.color_lens),
                title: Text('Scrabble Edition'),
                onPressed: (context) {
                  // Navigate to the second screen when tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScrabbleEditionSettingsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
