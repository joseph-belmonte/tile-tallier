import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/settings_controller.dart';

/// A page that displays the gameplay settings for the app
class GameplaySettingsPage extends ConsumerWidget {
  /// Creates a new [GameplaySettingsPage] instance.
  const GameplaySettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gameplay Settings'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('Word Check'),
            subtitle: Text(
              'Check words against an open-source word list.',
            ),
            value: ref.watch(Settings.isWordCheckProvider),
            onChanged: (bool value) {
              ref.read(Settings.isWordCheckProvider.notifier).set(value);
            },
          ),
        ],
      ),
    );
  }
}
