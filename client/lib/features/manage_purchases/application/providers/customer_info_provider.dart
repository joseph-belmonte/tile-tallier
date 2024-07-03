import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// A [StateNotifier] that fetches the customer info from the RevnueCatPurchases SDK.
class CustomerInfoNotifier extends StateNotifier<CustomerInfo?> {
  /// Creates a new [CustomerInfoNotifier] instance.
  CustomerInfoNotifier() : super(null) {
    _fetchCustomerInfo();
  }

  Future<void> _fetchCustomerInfo() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      state = customerInfo;
    } on PlatformException catch (e) {
      // Error fetching customer info
      print(e.message);

      state = null;
    }
  }

  /// Restores purchases for the user.
  Future<void> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      state = customerInfo;
    } catch (e) {
      print(e);
    }
  }

  /// Purchases a package.
  Future<void> purchasePackage(Package package) async {
    try {
      final customerInfo = await Purchases.purchasePackage(package);
      state = customerInfo;
    } catch (e) {
      print(e);
    }
  }
}

/// A [StateNotifierProvider] that provides the [CustomerInfoNotifier] instance.
final customerInfoProvider =
    StateNotifierProvider<CustomerInfoNotifier, CustomerInfo?>((ref) {
  return CustomerInfoNotifier();
});
