import 'package:flutter/material.dart';

import 'appearance_settings.dart';

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
      body: Align(
        alignment: Alignment.topCenter,
        child: ListView(
          children: <ListTile>[
            ListTile(
              title: Text('Appearance'),
              subtitle: Text('Edit the appearance of the app'),
              leading: Icon(Icons.color_lens),
              trailing: Icon(Icons.arrow_forward_sharp),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppearanceSettingsPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
