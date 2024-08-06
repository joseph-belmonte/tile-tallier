import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../enums/word_theme.dart';
import '../../features/edit_settings/application/providers/key_value_db_listener.dart';
import '../../features/edit_settings/application/providers/key_value_db_provider.dart';
import '../../features/manage_purchases/application/configure_rc_sdk.dart';
import '../../features/manage_purchases/application/providers/customer_info_provider.dart';

import '../../features/play_game/data/helpers/word_database_helper.dart';

/// Checks if the database is populated. If not, import the word list.
Future<void> initWordDatabase() async {
  try {
    await WordListDBHelper.instance.database;
    final isPopulated = await WordListDBHelper.instance.isDatabasePopulated();

    if (!isPopulated) {
      for (var theme in WordTheme.values) {
        await WordListDBHelper.instance.populateTable(theme: theme);
      }
    }
  } catch (e) {
    throw Exception('Error initializing word database: $e');
  }
}

/// Initializes the app.
Future<void> initializeApp(ProviderContainer settingsContainer) async {
  await initWordDatabase();
  await configureRcSdk();

  // Get default keyValueDb implementation and initialize it for use.
  await settingsContainer.read(keyValueDbProvider).init();

  // By reading the keyValueDbListenerProvider, we instantiate it. This sets up
  // a listener that listens to state changes in keyValueDbProvider. In the
  // listener we use SharedPreferences to save the state of the keyValueDbProvider.
  settingsContainer.read(keyValueDbListenerProvider);

  // Initialize customer info provider
  settingsContainer.read(customerInfoProvider.notifier);
}
