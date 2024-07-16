import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A dialog that can be dismissed by the user.
class ShowDialogToDismiss extends StatelessWidget {
  /// The content of the dialog.
  final String content;

  /// The title of the dialog.
  final String title;

  /// The text of the button that dismisses the dialog.
  final String buttonText;

  /// Creates a new [ShowDialogToDismiss] instance.
  const ShowDialogToDismiss({
    required this.title,
    required this.buttonText,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return AlertDialog(
        title: Text(
          title,
        ),
        content: Text(
          content,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              buttonText,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return CupertinoAlertDialog(
        title: Text(
          title,
        ),
        content: Text(
          content,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(
              buttonText[0].toUpperCase() +
                  buttonText.substring(1).toLowerCase(),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }
}
