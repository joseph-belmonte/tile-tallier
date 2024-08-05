import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../enums/word_theme.dart';

import '../controllers/settings_controller.dart';
import 'theme_wordlist_settings.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            SwitchListTile(
              title: Text('Word Check'),
              subtitle: Text('Check words against an open-source word list.'),
              value: ref.watch(Settings.isWordCheckProvider),
              onChanged: (bool value) {
                ref.read(Settings.isWordCheckProvider.notifier).set(value);
                if (!value) {
                  ref
                      .read(Settings.wordThemeProvider.notifier)
                      .set(WordTheme.basic.name);
                }
              },
            ),
            ListTile(
              title: const Text('Themed Gameplay'),
              subtitle: const Text(
                'Choose whether to play with themed words. This feature requires the word check to be enabled.',
              ),
              enabled: ref.read(Settings.isWordCheckProvider),
              trailing: ref.read(Settings.isWordCheckProvider) == false
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ThemedGameplaySettingsPage(),
                          ),
                        );
                      },
                    ),
            ),
            SwitchListTile(
              title: Text('Display Timer'),
              subtitle: Text('Display a timer during gameplay.'),
              value: ref.watch(Settings.isTimerEnabledProvider),
              onChanged: (bool value) {
                ref.read(Settings.isTimerEnabledProvider.notifier).set(value);
                if (value) {
                  ref.read(Settings.timerDurationProvider.notifier).set(60);
                } else {
                  ref.read(Settings.timerDurationProvider.notifier).set(null);
                }
              },
            ),
            ListTile(
              title: const Text('Timer Duration'),
              subtitle: const Text(
                'Set the duration of the timer display, in seconds.',
              ),
              enabled: ref.watch(Settings.isTimerEnabledProvider),
              trailing: SizedBox(
                width: 120,
                child: Slider(
                  value: ref.watch(Settings.timerDurationProvider) == null
                      ? 60
                      : ref.watch(Settings.timerDurationProvider)!.toDouble(),
                  onChanged: ref.watch(Settings.isTimerEnabledProvider)
                      ? (double value) {
                          ref
                              .read(Settings.timerDurationProvider.notifier)
                              .set(value.toInt());
                        }
                      : null,
                  min: 30,
                  max: 120,
                  divisions: 3,
                  label: ref.watch(Settings.timerDurationProvider).toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
