import 'package:flutter/material.dart';

import '../../../shared/presentation/widgets/loading_spinner.dart';
import 'home.dart';

/// The splash screen to display during app initialization.
class SplashScreen extends StatefulWidget {
  /// Creates a new splash screen.
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay by 500ms to show the splash screen
    // Then navigate to the home screen
    Future.delayed(Durations.long4, () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadingSpinner(),
    );
  }
}
