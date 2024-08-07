import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';

/// Launches confetti on the screen.
void launchConfetti(BuildContext context) {
  final confettiOptions = ConfettiOptions(
    particleCount: 50,
    spread: 50,
    x: 0.5,
    y: 0.9,
    gravity: 0.75,
    colors: <Color>[
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiary,
    ],
  );

  Confetti.launch(context, options: confettiOptions);
}
