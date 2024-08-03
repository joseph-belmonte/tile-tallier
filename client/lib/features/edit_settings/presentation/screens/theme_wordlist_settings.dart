import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../enums/word_theme.dart';
import '../../../play_game/data/word_database_helper.dart';
import '../../../shared/presentation/widgets/animate_in_check_icon.dart';
import '../../../shared/presentation/widgets/animate_out_check_icon.dart';
import '../controllers/settings_controller.dart';
import 'word_list_display.dart';

/// A page for managing the themed word list selection.
class ThemedGameplaySettingsPage extends ConsumerWidget {
  /// Creates a new [ThemedGameplaySettingsPage] instance.
  const ThemedGameplaySettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(Settings.wordThemeProvider);

    void handleNavigation(WordTheme wordTheme) async {
      if (await WordListDBHelper.instance.queryRowCount(theme: wordTheme) ==
          0) {
        await WordListDBHelper.instance.populateTable(theme: wordTheme);
      }
      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => WordListDisplayPage(themeName: wordTheme.name),
          ),
        );
      }
    }

    final sortedThemes = WordTheme.values.toList()
      ..sort(
        (a, b) {
          if (a == WordTheme.basic) {
            return -1;
          }
          return a.name.compareTo(b.name);
        },
      );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Themed Gameplay Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            const ListTile(
              title: Text('Select a theme'),
              subtitle: Text(
                'When playing with a theme, only words related to that theme will be accepted.',
              ),
            ),
            ...sortedThemes.map(
              (wordTheme) {
                return ListTile(
                  title: Text(wordTheme.name),
                  subtitle: Text(wordTheme.description),
                  leading: IconButton(
                    icon: const Icon(Icons.abc_sharp),
                    onPressed: () => handleNavigation(wordTheme),
                  ),
                  trailing: ref.read(Settings.isWordCheckProvider) == false
                      ? null
                      : wordTheme == getWordTheme(currentTheme)
                          ? const AnimateInCheckIcon()
                          : const AnimateOutCheckIcon(),
                  onTap: () {
                    ref
                        .read(Settings.wordThemeProvider.notifier)
                        .set(wordTheme.name);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
