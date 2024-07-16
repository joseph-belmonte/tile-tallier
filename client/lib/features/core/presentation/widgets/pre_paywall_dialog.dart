import 'package:flutter/material.dart';

import '../../../../utils/show_paywall.dart';

/// A dialog to prompt the user to unlock the full game.
class PrePaywallDialogue extends StatelessWidget {
  /// Creates a new [PrePaywallDialogue] instance.
  const PrePaywallDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Unlock Full Game'),
      content: const Text(
        'Unlock the full application to score unlimited games, use premium themes, and the ability to score a game with your friends.',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () async {
            await showPaywall(context);
            if (!context.mounted) return;
            Navigator.pop(context);
          },
          child: Text(
            'Unlock',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
      ],
    );
  }
}
