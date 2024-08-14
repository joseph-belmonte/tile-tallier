import 'package:flutter/material.dart';

/// Creates a scale route for the given page.
Route createErrorRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: Durations.medium1,
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      // Define the scale transition from a small size to full size
      return ScaleTransition(
        alignment: Alignment.topCenter,
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
        ),
        child: child,
      );
    },
  );
}
