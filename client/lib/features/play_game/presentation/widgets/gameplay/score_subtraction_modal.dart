import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/game_play_storage.dart';
import '../../../../history/application/providers/history_repository_provider.dart';
import '../../../application/providers/active_game.dart';
import '../../screens/results.dart';

/// A modal that allows the user to input the leftover tiles on each player's rack.
class ScoreSubtractionModal extends ConsumerStatefulWidget {
  /// Creates a new [ScoreSubtractionModal] instance.
  const ScoreSubtractionModal({super.key});

  @override
  ConsumerState<ScoreSubtractionModal> createState() =>
      _ScoreSubtractionModalState();
}

class _ScoreSubtractionModalState extends ConsumerState<ScoreSubtractionModal> {
  final _formKey = GlobalKey<FormState>();
  late List<TextEditingController> _controllers;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final playerCount = ref.read(activeGameProvider).players.length;
    _controllers = List.generate(playerCount, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitGameRacks() async {
    if (_formKey.currentState!.validate()) {
      final historyProvider = ref.read(historyRepositoryProvider);
      _updateGameRacks();

      await GamePlayStorage.setPlayedToday();

      // Save the game to the database:
      final completedGame = ref.read(activeGameProvider);

      if (completedGame.plays.isEmpty) {
        return;
      }

      await historyProvider.submitGameData(completedGame);

      if (!context.mounted) return;
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ResultsPage(game: ref.read(activeGameProvider)),
        ),
      );
    }
  }

  void _updateGameRacks() {
    final playerRacks =
        _controllers.map((controller) => controller.text.trim()).toList();

    final updatedPlayers =
        ref.read(activeGameProvider).players.asMap().entries.map((entry) {
      final index = entry.key;
      final player = entry.value;

      return player.copyWith(endRack: playerRacks[index]);
    }).toList();

    ref.read(activeGameProvider.notifier).updatePlayers(updatedPlayers);
  }

  @override
  Widget build(BuildContext context) {
    final players = ref.watch(activeGameProvider).players;

    // Ensure the controllers are updated whenever the number of players changes
    if (_controllers.length != players.length) {
      _initializeControllers();
    }

    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Enter the leftover tiles on each player\'s rack.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: players.length,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                child: TextFormField(
                  controller: _controllers[index],
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(7),
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    labelText: '${players[index].name}\'s Rack',
                  ),
                  validator: (value) =>
                      (value == null) ? 'Please enter tiles' : null,
                ),
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: LinearProgressIndicator(),
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.cancel,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    label: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color:
                                Theme.of(context).colorScheme.onErrorContainer,
                          ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.errorContainer,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _submitGameRacks,
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    label: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
