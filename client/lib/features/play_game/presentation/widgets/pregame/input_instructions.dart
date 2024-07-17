import 'package:flutter/material.dart';

/// A widget that displays instructions for inputting player names.
class InputInstructions extends StatelessWidget {
  /// Creates a new [InputInstructions] instance.
  const InputInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                textAlign: TextAlign.left,
                'Select a player to add them to the game.',
              ),
              Text(
                textAlign: TextAlign.left,
                'Enter a name below to add someone new.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
