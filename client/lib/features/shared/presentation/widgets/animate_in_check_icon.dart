import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

/// An animated check icon that fades in.
class AnimateInCheckIcon extends StatelessWidget {
  /// Creates an animated check icon that fades in.
  const AnimateInCheckIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: const Icon(Icons.check),
    );
  }
}
