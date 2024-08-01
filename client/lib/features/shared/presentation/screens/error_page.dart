import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../core/presentation/screens/home.dart';
import '../../../edit_settings/presentation/screens/settings.dart';

/// A page to display when an error occurs.
class ErrorPage extends StatelessWidget {
  /// Creates a new [ErrorPage] instance.
  const ErrorPage({
    required this.errorMessage,
    required this.stackTrace,
    super.key,
  });

  /// The error message to display.
  final String errorMessage;

  /// The stack trace to display.
  final String stackTrace;

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
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ZoomIn(
                      duration: const Duration(seconds: 2),
                      child: Icon(
                        Icons.error,
                        size: 100,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'An error occurred.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'If you believe this is a bug, please report it from the settings page.',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: <Widget>[
                          Text(
                            stackTrace,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
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
                  label: const Text('Go Home'),
                  icon: const Icon(Icons.home),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SettingsPage(),
                      ),
                    );
                  },
                  label: const Text('Settings'),
                  icon: const Icon(Icons.settings),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
