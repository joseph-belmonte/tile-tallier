import 'package:flutter/material.dart';

import '../../../../core/presentation/screens/home.dart';

/// An alert dialog that asks the user if they want to quit the game.
class QuitGameAlert extends StatelessWidget {
  /// Creates a new [QuitGameAlert] instance.
  const QuitGameAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Quit Game'),
      content: const Text('Are you sure you want to quit the game?'),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'No',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement<void, void>(
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          },
          child: Text(
            'Yes',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
        ),
      ],
    );
  }
}
