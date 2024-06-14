// ignore_for_file: file_names

import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../utils/store_config.dart';
import '../data/constants/revenue_cat.dart';

/// Configures the RevenueCat SDK.
Future<void> configureRcSdk() async {
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
