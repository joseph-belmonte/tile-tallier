import 'package:flutter/material.dart';

import '../../../shared/presentation/screens/home.dart';

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
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement<void, void>(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
