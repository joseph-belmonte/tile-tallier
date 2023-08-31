import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../scrabble_scorer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('Appearance'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.nightlight),
              title: Text('Dark Mode'),
              onPressed: (context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DarkModeSettingsPage(),
                  ),
                );
              },
            ),
            SettingsTile.navigation(
              leading: Icon(Icons.color_lens),
              title: Text('Scrabble Edition'),
              // onPressed: () {
              //   // Navigate to the second screen when tapped
              //
              // },
            ),
          ],
        ),
      ],
    );
  }
}

class DarkModeSettingsPage extends StatelessWidget {
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
                onPressed: (context) {
                  Provider.of<AppState>(context, listen: false).themeMode =
                      ThemeMode.dark;
                },
              ),
              SettingsTile(
                title: Text('Light Mode'),
                onPressed: (context) {
                  Provider.of<AppState>(context, listen: false).themeMode =
                      ThemeMode.light;
                },
              ),
              SettingsTile(
                title: Text('System Default'),
                enabled: true,
                onPressed: (context) {
                  Provider.of<AppState>(context, listen: false).themeMode =
                      ThemeMode.system;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
