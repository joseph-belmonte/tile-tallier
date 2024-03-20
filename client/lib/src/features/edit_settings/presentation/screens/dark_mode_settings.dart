import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

/// A page that displays the dark mode settings for the app
class DarkModeSettingsPage extends StatelessWidget {
  /// Creates a new [DarkModeSettingsPage] instance.
  const DarkModeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: Text('Dark Mode'),
              ),
              SettingsTile(
                title: Text('Light Mode'),
              ),
              SettingsTile(
                title: Text('System Default'),
                enabled: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
