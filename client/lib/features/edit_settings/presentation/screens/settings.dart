import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../auth/application/providers/auth_provider.dart';
import '../../../auth/presentation/screens/account_management.dart';
import '../../../auth/presentation/screens/auth_screen.dart';
import '../../../manage_purchases/presentation/widgets/dismiss_dialog.dart';
import '../widgets/app_about_tile.dart';
import 'appearance_settings.dart';

/// A page that displays the settings for the app
class SettingsPage extends ConsumerStatefulWidget {
  /// Creates a new [SettingsPage] instance.
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  // ignore: unused_field
  bool _isLoading = false;

  void _restore() async {
    setState(() => _isLoading = true);

    try {
      await Purchases.restorePurchases();
      await Purchases.appUserID;
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
    final authState = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Account Management'),
              subtitle: authState.isAuthenticated
                  ? Text('Manage your account settings')
                  : Text('Sign in to manage your account settings'),
              leading: Icon(Icons.account_circle),
              trailing: Icon(Icons.arrow_forward_sharp),
              onTap: () {
                if (authState.isAuthenticated) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AccountManagementScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthScreen(),
                    ),
                  );
                }
              },
            ),
            ListTile(
              title: Text('Appearance'),
              subtitle: Text('Edit the appearance of the app'),
              leading: Icon(Icons.color_lens),
              trailing: Icon(Icons.arrow_forward_sharp),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppearanceSettingsPage(),
                ),
              ),
            ),
            ListTile(
              title: Text('Submit a bug report'),
              subtitle: Text('Let us know if you find a bug'),
              leading: Icon(Icons.bug_report_outlined),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                try {
                  BetterFeedback.of(context).show((UserFeedback feedback) async {
                    // Save the screenshot to a file and get the file path
                    final imageInUnit8List = feedback.screenshot;
                    final tempDir = await getTemporaryDirectory();
                    final file = await File('${tempDir.path}/image.png').create();
                    file.writeAsBytesSync(imageInUnit8List);
                    final email = Email(
                      subject: 'App Feedback',
                      body: feedback.text,
                      attachmentPaths: [file.path],
                      recipients: ['tile_tally@belmo.dev'],
                    );

                    try {
                      await FlutterEmailSender.send(email);
                      if (context.mounted) _showSuccessSnackBar(context);
                    } on Exception catch (e) {
                      if (context.mounted) _showErrorSnackBar(context, e);
                    }
                  });
                } on Exception catch (error) {
                  if (context.mounted) _showErrorSnackBar(context, error);
                }
              },
            ),
            ListTile(
              title: Text('Restore Purchases'),
              subtitle: Text('Restore your purchases if you have reinstalled the app'),
              leading: Icon(Icons.restore),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _restore,
            ),
            AppAboutTile(),
          ],
        ),
      ),
    );
  }
}

void _showSuccessSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text('Feedback sent successfully'),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ),
  );
}

void _showErrorSnackBar(BuildContext context, Exception error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Error sending feedback: $error'),
      backgroundColor: Theme.of(context).colorScheme.error,
    ),
  );
}
