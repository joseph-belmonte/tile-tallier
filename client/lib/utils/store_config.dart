import 'package:purchases_flutter/purchases_flutter.dart';

/// Configuration for the store and API keys
class StoreConfig {
  /// The store to use
  final Store store;

  /// The API key to use
  final String apiKey;

  static StoreConfig? _instance;

  /// Create a new instance of [StoreConfig]
  factory StoreConfig({required Store store, required String apiKey}) {
    _instance ??= StoreConfig._internal(store, apiKey);
    return _instance!;
  }

  StoreConfig._internal(this.store, this.apiKey);

  /// Get the instance of [StoreConfig]
  static StoreConfig get instance {
    return _instance!;
  }

  /// Check if the store is for Apple
  static bool isForAppleStore() => instance.store == Store.appStore;

  /// Check if the store is for Google
  static bool isForGooglePlay() => instance.store == Store.playStore;
}
