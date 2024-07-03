import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../theme/constants/premium_themes.dart';
import '../../../../theme/models/app_theme.dart';

import '../../../../utils/show_paywall.dart';
import '../../../manage_purchases/data/constants/revenue_cat.dart';
import '../../../manage_purchases/presentation/widgets/dismiss_dialog.dart';
import '../controllers/settings_controller.dart';

/// A page that displays a list of theme options for the app
class ThemeScreen extends ConsumerStatefulWidget {
  /// Creates a new [ThemeScreen] instance.
  const ThemeScreen({super.key});

  @override
  ConsumerState<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends ConsumerState<ThemeScreen> {
  bool _isLoading = false;
  bool _isSubscribed = false;

  @override
  void initState() {
    super.initState();
    _checkSubscriptionStatus();
  }

  Future<void> _checkSubscriptionStatus() async {
    setState(() => _isLoading = true);
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      if (customerInfo.entitlements.all[entitlementID]?.isActive == true) {
        setState(() => _isSubscribed = true);
      }
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
      }
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theming'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
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
                    leading: AppTheme.premiumSchemes.contains(scheme) &&
                            !_isSubscribed
                        ? const Icon(Icons.lock)
                        : const Icon(Icons.palette),
                    trailing: ref.watch(Settings.schemeIndexProvider) ==
                            AppTheme.schemes.indexOf(scheme)
                        ? const Icon(Icons.check)
                        : null,
                    onTap: () async {
                      final index = AppTheme.schemes.indexOf(scheme);
                      final isPremium =
                          AppTheme.premiumSchemes.contains(scheme);

                      if (isPremium && !_isSubscribed) {
                        await showPaywall(context);
                      } else {
                        ref
                            .read(Settings.schemeIndexProvider.notifier)
                            .set(index);
                        ref
                            .read(Settings.isPremiumThemeProvider.notifier)
                            .set(isPremium);
                        final premiumIdx =
                            index - AppTheme.defaultSchemes.length;
                        ref.read(Settings.premiumThemeProvider.notifier).set(
                              isPremium
                                  ? PremiumTheme.values[premiumIdx]
                                  : null,
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
