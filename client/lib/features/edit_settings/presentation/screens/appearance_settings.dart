import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../enums/scrabble_edition.dart';
import '../../../../theme/controllers/theme_providers.dart';
import '../../../shared/presentation/widgets/animate_in_check_icon.dart';
import '../../../shared/presentation/widgets/animate_out_check_icon.dart';
import '../controllers/settings_controller.dart';
import 'theme_screen.dart';

/// A page that displays the dark mode settings for the app
class AppearanceSettingsPage extends ConsumerWidget {
  /// Creates a new [AppearanceSettingsPage] instance.
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(Settings.themeModeProvider);
    final scarbbleEdition = ref.watch(scrabbleEditionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Theming'),
            subtitle: const Text('Check out our premium themes!'),
            leading: const Icon(Icons.color_lens),
            trailing: const Icon(Icons.arrow_forward_sharp),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ThemeScreen()),
            ),
          ),
          Divider(),
          ListTile(
            title: const Text('Brightness'),
            leading: const Icon(Icons.brightness_4),
            subtitle: const Text('Edit display brightness settings'),
          ),
          ListTile(
            title: const Text('System Mode'),
            leading: const Icon(Icons.phone_android),
            trailing: themeMode.index == 0 ? AnimateInCheckIcon() : AnimateOutCheckIcon(),
            onTap: () => ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.system),
          ),
          ListTile(
            title: const Text('Light Mode'),
            leading: const Icon(Icons.light_mode),
            trailing: themeMode.index == 1 ? AnimateInCheckIcon() : AnimateOutCheckIcon(),
            onTap: () => ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.light),
          ),
          ListTile(
            title: const Text('Dark Mode'),
            leading: const Icon(Icons.dark_mode),
            trailing: themeMode.index == 2 ? AnimateInCheckIcon() : AnimateOutCheckIcon(),
            onTap: () => ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.dark),
          ),
          Divider(),
          ListTile(
            title: const Text('Scrabble edition'),
            subtitle: const Text('Edit the display of tiles'),
            leading: const Icon(Icons.format_color_text),
          ),
          ListTile(
            title: const Text('Classic'),
            leading: const Icon(Icons.format_color_text),
            trailing: scarbbleEdition == ScrabbleEdition.classic
                ? AnimateInCheckIcon()
                : AnimateOutCheckIcon(),
            onTap: () => ref.read(scrabbleEditionProvider.notifier).state = ScrabbleEdition.classic,
          ),
          ListTile(
            title: const Text('Hasbro'),
            leading: const Icon(Icons.format_color_text),
            trailing: scarbbleEdition == ScrabbleEdition.hasbro
                ? AnimateInCheckIcon()
                : AnimateOutCheckIcon(),
            onTap: () => ref.read(scrabbleEditionProvider.notifier).state = ScrabbleEdition.hasbro,
          ),
        ],
      ),
    );
  }
}
