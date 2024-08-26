import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../history/domain/models/player.dart';
import '../controllers/coaching_page_controller.dart';
import '../widgets/ai_intro.dart';

/// A page for coaching users on how to play the game using the gemini API.
class CoachingPage extends ConsumerStatefulWidget {
  /// Creates a new [CoachingPage] instance.
  const CoachingPage({super.key});

  @override
  ConsumerState<CoachingPage> createState() => _CoachingPageState();
}

class _CoachingPageState extends ConsumerState<CoachingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(coachingControllerProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(coachingControllerProvider);
    final controller = ref.read(coachingControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Coaching')),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Wrap(
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AIIntro(),
                  ),
                ],
              ),
              if (!state.isAuthenticated)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('You must be signed in to select a player'),
                ),
              _buildPlayerSelection(context, state, controller),
              Visibility(
                visible: !state.isLoading,
                replacement: const Center(child: CircularProgressIndicator()),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(state.advice),
                ),
              ),
              // Display the days until the next advice
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Days until next advice: ${state.daysUntilNextAdvice.toString()}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              // Display the date of the last fetched advice

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Text(
                  'Note: coach is based on Google\'s Gemini AI model and may provide incorrect advice',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSelection(
    BuildContext context,
    CoachingPageState state,
    CoachingController controller,
  ) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Select a player:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(width: 24.0),
        DropdownButton<String>(
          value: state.playerId,
          onChanged: state.isAuthenticated ? controller.selectPlayer : null,
          items: state.players.map((Player player) {
            return DropdownMenuItem<String>(
              value: player.id,
              child: Text(
                player.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
