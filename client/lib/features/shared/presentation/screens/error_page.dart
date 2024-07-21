import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../core/presentation/screens/home.dart';
import '../../../edit_settings/presentation/screens/settings.dart';

/// A page to display when an error occurs.
class ErrorPage extends StatelessWidget {
  /// Creates a new [ErrorPage] instance.
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ZoomIn(
                duration: Durations.extralong4,
                child: Icon(
                  Icons.error,
                  size: 100,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'An error occurred.',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Please let us know if this issue persists by submitting a bug report from the settings page.',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  },
                  label: Text('Go Home'),
                  icon: Icon(Icons.home),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    );
                  },
                  label: Text('Settings'),
                  icon: Icon(Icons.settings),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
