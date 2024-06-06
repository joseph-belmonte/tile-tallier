import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/app_about_tile.dart';
import 'appearance_settings.dart';

/// A page that displays the settings for the app
class SettingsPage extends StatelessWidget {
  /// Creates a new [SettingsPage] instance.
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
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
                      recipients: ['scrabble_scorer@belmo.dev'],
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
