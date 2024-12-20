import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../utils/toast.dart';

/// A tile that allows the user to submit feedback
class SubmitFeedbackTile extends StatelessWidget {
  /// Creates a new [SubmitFeedbackTile] instance.
  const SubmitFeedbackTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
              recipients: ['example@example.com'],
            );

            try {
              await FlutterEmailSender.send(email);
              if (context.mounted) {
                ToastService.message(
                  context,
                  'Feedback sent successfully',
                );
              }
            } on Exception catch (e) {
              if (context.mounted) {
                ToastService.error(
                  context,
                  'Error sending feedback: $e',
                );
              }
            }
          });
        } on Exception catch (error) {
          if (context.mounted) ToastService.error(context, '$error');
        }
      },
    );
  }
}
