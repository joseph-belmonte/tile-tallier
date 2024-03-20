import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

/// A page that displays the settings for the Scrabble edition.
class ScrabbleEditionSettingsPage extends StatelessWidget {
  /// Creates a new [ScrabbleEditionSettingsPage] instance.
  const ScrabbleEditionSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              ),
              SettingsTile(
                title: Text('25th Anniversary'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
