import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../utils/game_play_storage.dart';
import '../../../../../utils/logger.dart';
import '../../../../core/domain/models/game.dart';
import '../../../../view_past_games/application/providers/history_repository_provider.dart';
import '../../../../view_past_games/data/helpers/master_database_helper.dart';
import '../../../../view_past_games/domain/models/player.dart';
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
    final db = await MasterDatabaseHelper.instance.database;

    if (_formKey.currentState!.validate()) {
      _updateGameRacks();

      await GamePlayStorage.setPlayedToday();

      if (!context.mounted) return;

      // Save the game to the database:
      final completedGame = ref.read(activeGameProvider);

      if (completedGame.plays.isEmpty) {
        return;
      }

      await _submitDataToDatabase(db, completedGame);

      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultsPage(game: ref.read(activeGameProvider)),
        ),
      );
      logger.d('Navigated to results page');
    }
  }

  Future<void> _submitDataToDatabase(Database db, Game completedGame) async {
    await db.transaction((txn) async {
      // Save the game
      await ref.read(historyRepositoryProvider).saveGame(completedGame, txn);
      logger.d('Saved game to database');

      // Save the Players
      for (var gamePlayer in completedGame.players) {
        // Check if the player already exists in the database
        final player = await ref
            .read(historyRepositoryProvider)
            .fetchPlayer(gamePlayer.playerId, txn);
        logger.d('Fetched player from database');

        // If the player does not exist, save them to the database
        if (player == null) {
          final newPlayer =
              Player(name: gamePlayer.name, id: gamePlayer.playerId);
          await ref.read(historyRepositoryProvider).savePlayer(newPlayer, txn);
          logger.d('Saved player to database');
        }
      }
    });
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
