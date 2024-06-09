import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'features/edit_settings/application/providers/key_value_db_listener.dart';
import 'features/edit_settings/application/providers/key_value_db_provider.dart';
import 'features/manage_purchases/data/constants/revenue_cat.dart';
import 'theme/theme_wrapper.dart';
import 'utils/database_helper.dart';
import 'utils/store_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isIOS || Platform.isMacOS) {
    StoreConfig(
      store: Store.appStore,
      apiKey: appleAPIKey,
    );
  } else if (Platform.isAndroid) {
    StoreConfig(
      store: Store.playStore,
      apiKey: googleAPIKey,
    );
  }

  final container = ProviderContainer();

  // Get default keyValueDb implementation and initialize it for use.
  await container.read(keyValueDbProvider).init();

  // By reading the keyValueDbListenerProvider, we instantiate it. This sets up
  // a listener that listens to state changes in keyValueDbProvider. In the
  // listener we use SharedPreferences to save the state of the keyValueDbProvider.
  container.read(keyValueDbListenerProvider);

  // Check if the database is populated. If not, import the word list.
  if (!await DatabaseHelper.instance.isDatabasePopulated()) {
    await DatabaseHelper.instance.importWordList();
  }

  /// Configure the RevenueCat SDK.
  Future<void> configureSDK() async {
    // Configure the RevenueCat SDK.
    await Purchases.setLogLevel(LogLevel.debug);
    /*
    - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids

    - observerMode is false, so Purchases will automatically handle finishing transactions. Read more about Observer Mode here: https://docs.revenuecat.com/docs/observer-mode
    */
    PurchasesConfiguration configuration;

    configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
      ..appUserID = null
      ..observerMode = false;

    await Purchases.configure(configuration);
  }

  await configureSDK();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: ProviderScope(
        child: const ThemeWrapper(),
      ),
    ),
  );
}
