import 'package:flutter/material.dart';

/// A tile that displays information about the app.
class AppAboutTile extends StatelessWidget {
  /// Creates a new [AppAboutTile] instance.
  const AppAboutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationIcon: const FlutterLogo(size: 56),
      icon: const Icon(Icons.info),
      applicationName: 'Scrabble Score Keeper',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024',
      dense: true,
    );
  }
}
