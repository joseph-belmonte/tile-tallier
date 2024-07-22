import 'package:flutter/material.dart';

import '../../../core/presentation/screens/home.dart';

/// A button that navigates to the home page.
class HomeButton extends StatelessWidget {
  /// Creates a new [HomeButton] instance.
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
      ),
      icon: Icon(
        Icons.home,
        color: Theme.of(context).colorScheme.primary,
      ),
      label: Text(
        'Home',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
