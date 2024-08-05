import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/account_management_tile.dart';
import '../widgets/app_about_tile.dart';
import '../widgets/restore_purchase_tile.dart';
import '../widgets/submit_feedback_tile.dart';
import 'appearance_settings.dart';
import 'gameplay_settings.dart';
import 'privacy_policy.dart';
import 'terms_and_conditions.dart';

/// A page that displays the settings for the app
class SettingsPage extends ConsumerWidget {
  /// Creates a new [SettingsPage] instance.
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            AccountManagementTile(),
            ListTile(
              title: Text('Appearance'),
              subtitle: Text('Edit the appearance of the app'),
              leading: Icon(Icons.color_lens),
              trailing: Icon(Icons.arrow_forward_sharp),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AppearanceSettingsPage(),
                ),
              ),
            ),
            SubmitFeedbackTile(),
            RestorePurchaseTile(),
            ListTile(
              title: Text('Terms and Conditions'),
              subtitle: Text('Read the terms and conditions'),
              leading: Icon(Icons.abc),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const TermsAndConditions(),
                ),
              ),
            ),
            ListTile(
              title: Text('Privacy Policy'),
              subtitle: Text('Read the privacy policy'),
              leading: Icon(Icons.privacy_tip_outlined),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PrivacyPolicy()),
              ),
            ),
            ListTile(
              title: Text('Gameplay'),
              subtitle: Text('Edit the gameplay settings'),
              leading: Icon(Icons.sports_esports),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const GameplaySettingsPage()),
              ),
            ),
            AppAboutTile(),
          ],
        ),
      ),
    );
  }
}
