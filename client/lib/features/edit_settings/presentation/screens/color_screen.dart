import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/models/app_theme.dart';
import '../controllers/settings.dart';

/// A page that displays the dark mode settings for the app
class ColorScreen extends ConsumerWidget {
  /// Creates a new [ColorScreen] instance.
  const ColorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Theme'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Primary Color'),
            subtitle: const Text('Edit the primary color of the app'),
            leading: const Icon(Icons.color_lens),
          ),
          Divider(
            indent: 48,
            endIndent: 48,
          ),
          ...AppTheme.schemes.map(
            (final FlexSchemeData scheme) => ListTile(
              title: Text(scheme.name),
              subtitle: Text(scheme.description),
              leading: Icon(Icons.color_lens),
              trailing: AppTheme.schemes[ref.watch(Settings.schemeIndexProvider)] == scheme
                  ? const Icon(Icons.check)
                  : null,
              onTap: () => ref
                  .read(Settings.schemeIndexProvider.notifier)
                  .set(AppTheme.schemes.indexOf(scheme)),
            ),
          ),
        ],
      ),
    );
  }
}
