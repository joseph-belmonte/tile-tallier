import 'package:flutter/material.dart';

/// A widget that displays a centered [CircularProgressIndicator].
class LoadingSpinner extends StatelessWidget {
  /// Creates a new [LoadingSpinner] instance.
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
