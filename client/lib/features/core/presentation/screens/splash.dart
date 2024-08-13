import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/presentation/widgets/loading_spinner.dart';

import '../../application/providers/daily_word_provider.dart';
import 'home.dart';

/// The splash screen to display during app initialization.
class SplashScreen extends ConsumerStatefulWidget {
  /// Creates a new splash screen.
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _autoNavigate();
  }

  Future<void> _autoNavigate() async {
    // Wait until the word is loaded, then delay and navigate
    await ref.read(wordOfTheDayProvider.future);
    Future.delayed(Durations.extralong1, () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final wordAsyncValue = ref.watch(wordOfTheDayProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const LoadingSpinner(),
            const SizedBox(height: 20),
            const Text('Initializing App...'),
            const SizedBox(height: 60),
            wordAsyncValue.when(
              data: (word) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'The word of the day is ',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      word,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const Text('Error loading word of the day'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
