import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/edit_settings/application/providers/key_value_db_listener.dart';
import 'features/edit_settings/application/providers/key_value_db_provider.dart';
import 'theme/theme_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();

  // Get default keyValueDb implementation and initialize it for use.
  await container.read(keyValueDbProvider).init();

  // By reading the keyValueDbListenerProvider, we instantiate it. This sets up
  // a listener that listens to state changes in keyValueDbProvider. In the
  // listener we use SharedPreferences to save the state of the keyValueDbProvider.
  container.read(keyValueDbListenerProvider);
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: ProviderScope(
        child: ThemeWrapper(),
      ),
    ),
  );
}
