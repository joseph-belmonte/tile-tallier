import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../theme/constants/premium_themes.dart';
import '../../../../theme/models/app_theme.dart';
import '../../../manage_purchases/data/constants/revenue_cat.dart';
import '../../../manage_purchases/presentation/screens/paywall.dart';
import '../../../manage_purchases/presentation/widgets/dismiss_dialog.dart';
import '../controllers/settings.dart';

/// A page that displays a list of theme options for the app
class ThemeScreen extends ConsumerStatefulWidget {
  /// Creates a new [ThemeScreen] instance.
  const ThemeScreen({super.key});

  @override
  ConsumerState<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends ConsumerState<ThemeScreen> {
  // ignore: unused_field
  bool _isLoading = false;
  bool _isSubscribed = false;

  void checkSubscription() async {
    final customerInfo = await Purchases.getCustomerInfo();

    if (customerInfo.entitlements.all[entitlementID] != null &&
        customerInfo.entitlements.all[entitlementID]?.isActive == true) {
      setState(() => _isSubscribed = true);
    } else {
      Offerings? offerings;
      try {
        offerings = await Purchases.getOfferings();
      } on PlatformException catch (e) {
        if (mounted) {
          await showDialog(
            context: context,
            builder: (BuildContext context) => ShowDialogToDismiss(
              title: 'Error',
              content: e.message ?? 'Unknown error',
              buttonText: 'OK',
            ),
          );
        } else {
          print('Error: $e');
        }
      }

      if (offerings == null || offerings.current == null) {
        // todo: Show a message to the user that the offerings are empty.
        // offerings are empty, show a message to your user
      } else {
        // current offering is available, show paywall
        if (mounted) {
          await showModalBottomSheet(
            useRootNavigator: true,
            isDismissible: true,
            isScrollControlled: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Paywall(
                    offering: offerings!.current!,
                  );
                },
              );
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                if (isPremium && !_isSubscribed) {
                  setState(() => _isLoading = true);
                  checkSubscription();
                  setState(() => _isLoading = false);
                } else {
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
