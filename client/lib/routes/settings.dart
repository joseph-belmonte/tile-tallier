import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../widgets/keyboard.dart';
import '../models/game.dart';
import '../providers/app_state.dart';

class SettingsPage extends StatelessWidget {
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
                  children: [
                    Text(
                      Provider.of<AppState>(context).themeMode.toString(),
                    ),
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
              SettingsTile.navigation(
                leading: Icon(Icons.keyboard),
                title: Text('Keyboard'),
                trailing: Row(
                  children: [
                    Text(
                      Provider.of<AppState>(context).keyboardType.toString(),
                    ),
                    Icon(Icons.navigate_next),
                  ],
                ),
                onPressed: (context) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KeyboardSettingsPage(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DarkModeSettingsPage extends StatelessWidget {
  const DarkModeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: false);
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
                onPressed: (context) => appState.themeMode = ThemeMode.dark,
              ),
              SettingsTile(
                title: Text('Light Mode'),
                onPressed: (context) => appState.themeMode = ThemeMode.light,
              ),
              SettingsTile(
                title: Text('System Default'),
                enabled: true,
                onPressed: (context) => appState.themeMode = ThemeMode.system,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScrabbleEditionSettingsPage extends StatelessWidget {
  const ScrabbleEditionSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrabble Edition'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: Text('Classic'),
                enabled: true,
                onPressed: (context) => appState.edition = ScrabbleEdition.classic,
              ),
              SettingsTile(
                title: Text('25th Anniversary'),
                onPressed: (context) => appState.edition = ScrabbleEdition.twentyFifthAnniversary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KeyboardSettingsPage extends StatelessWidget {
  const KeyboardSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Keyboard Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: Text('Button Keyboard'),
                onPressed: (context) => appState.keyboardType = KeyboardType.button,
              ),
              SettingsTile(
                title: Text('Device Keyboard'),
                onPressed: (context) => appState.keyboardType = KeyboardType.device,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
