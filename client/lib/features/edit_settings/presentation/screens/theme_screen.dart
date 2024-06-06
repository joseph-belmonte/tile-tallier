import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/constants/premium_themes.dart';
import '../../../../theme/models/app_theme.dart';
import '../controllers/settings.dart';

/// A page that displays a list of theme options for the app
class ThemeScreen extends ConsumerWidget {
  /// Creates a new [ThemeScreen] instance.
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theming'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Primary Theme'),
            subtitle: const Text('Edit the theme of the app'),
            leading: const Icon(Icons.color_lens),
          ),
          Divider(indent: 48, endIndent: 48),
          ...AppTheme.schemes.map(
            (FlexSchemeData scheme) => ListTile(
              splashColor: scheme.light.primary.withOpacity(0.75),
              iconColor: scheme.light.primary,
              title: Text(scheme.name),
              subtitle: Text(scheme.description),
              // If it is a premium theme, and if the user has not unlocked it yet,
              // show a lock icon.
              leading: (AppTheme.premiumSchemes.contains(scheme) && true)
                  ? const Icon(Icons.lock)
                  : const Icon(Icons.palette),
              trailing: ref.watch(Settings.schemeIndexProvider) == AppTheme.schemes.indexOf(scheme)
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                final index = AppTheme.schemes.indexOf(scheme);
                final isPremium = index > AppTheme.defaultSchemes.length - 1;

                // If it is a premium theme, and if the user has not unlocked it yet,
                // show a purchase pop up.
                if (isPremium && true) {
                  print('Redirect to purchase screen.');
                } else
                // Otherwise, set the theme.
                {
                  ref.read(Settings.schemeIndexProvider.notifier).set(index);
                  ref.read(Settings.isPremiumThemeProvider.notifier).set(isPremium);
                  final premiumIdx = index - AppTheme.defaultSchemes.length;
                  ref.read(Settings.premiumThemeProvider.notifier).set(
                        isPremium ? PremiumTheme.values[premiumIdx] : null,
                      );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
