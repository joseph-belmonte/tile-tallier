import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../edit_settings/presentation/screens/privacy_policy.dart';
import '../../../edit_settings/presentation/screens/terms_and_conditions.dart';
import '../../data/constants/revenue_cat.dart';

/// A page that displays a list of subscription options for the app
class Paywall extends ConsumerStatefulWidget {
  /// The RevenueCat [Offering] to display.
  final Offering offering;

  /// Creates a new [Paywall] instance.
  const Paywall({required this.offering, super.key});

  @override
  ConsumerState<Paywall> createState() => _PaywallState();
}

class _PaywallState extends ConsumerState<Paywall> {
  void _restorePurchase() async {
    try {
      await Purchases.restorePurchases();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Wrap(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              child: Center(
                child: Text('🧮 TallyTallier Pro', style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'TALLY TALLIER PRO',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            ListView.builder(
              itemCount: widget.offering.availablePackages.length,
              itemBuilder: (BuildContext context, int index) {
                final myProductList = widget.offering.availablePackages;
                return Card(
                  child: ListTile(
                    onTap: () async {
                      try {
                        final customerInfo = await Purchases.purchasePackage(myProductList[index]);
                        final entitlement = customerInfo.entitlements.all[entitlementID];
                        // appData is a basically a reference to the current user
                        // and has properties like:
                        // entitlementIsActive, appUserID, etc.
                        // ignore: unused_local_variable
                        final isSubscribed = entitlement?.isActive ?? false;
                      } catch (e) {
                        print(e);
                      }

                      if (context.mounted) {
                        setState(() {});
                        Navigator.pop(context);
                      }
                    },
                    title: Text(
                      myProductList[index].storeProduct.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      myProductList[index].storeProduct.description,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    trailing: Text(
                      myProductList[index].storeProduct.priceString,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        footerText,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => const TermsAndConditions()));
                        },
                        child: Text(
                          'Terms of Service',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => const PrivacyPolicy()));
                        },
                        child: Text(
                          'Privacy Policy',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      TextButton(
                        onPressed: _restorePurchase,
                        child: Text(
                          'Already subscribed? Restore purchase.',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
