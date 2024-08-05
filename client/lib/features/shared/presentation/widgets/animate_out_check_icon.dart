import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

/// An animated check icon that fades out.
class AnimateOutCheckIcon extends StatelessWidget {
  /// Creates an animated check icon that fades out.
  const AnimateOutCheckIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomOut(
      duration: Durations.short4,
      child: const Icon(Icons.check),
    );
  }
}
