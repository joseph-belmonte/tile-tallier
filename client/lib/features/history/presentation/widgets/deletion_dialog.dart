import 'package:flutter/material.dart';

/// A dialog that prompts the user to confirm the deletion of all games.
Future<void> showDeletionDialog(
  BuildContext context, {
  required void Function()? onConfirm,
}) async {
  return await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete all games?'),
      content: const Text(
        'Are you sure you want to delete all player and game data? This action cannot be undone.',
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
          onPressed: onConfirm,
          child: Text(
            'Delete',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
        ),
      ],
    ),
  );
}
