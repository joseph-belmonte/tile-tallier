import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/edit_settings/application/providers/key_value_db_listener.dart';
import 'features/edit_settings/application/providers/key_value_db_provider.dart';
import 'theme/theme_wrapper.dart';
import 'utils/app_provider_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer(
    // This observer is used for logging changes in all Riverpod providers.
    observers: <ProviderObserver>[AppProviderObserver()],
  );

  // Get default keyValueDb implementation and initialize it for use.
  await container.read(keyValueDbProvider).init();

  // By reading the keyValueDbListenerProvider, we instantiate it. This sets up
  // a listener that listens to state changes in keyValueDbProvider. In the
  // listener we use SharedPreferences to save the state of the keyValueDbProvider.
  container.read(keyValueDbListenerProvider);
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: ThemeWrapper(),
    ),
  );
}
