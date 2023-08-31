import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

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
              onPressed: (BuildContext context) {
                print('navigate to dark mode settings');
              },
            ),
            SettingsTile.navigation(
              leading: Icon(Icons.color_lens),
              title: Text('Scrabble Edition'),
            ),
          ],
        ),
      ],
    );
  }
}
