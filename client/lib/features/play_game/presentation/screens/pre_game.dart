import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/active_game.dart';
import '../controllers/pre_game_controller.dart';
import '../widgets/pregame/player_count_control.dart';
import '../widgets/pregame/player_input_fields.dart';
import '../widgets/pregame/player_selection_chips.dart';
import '../widgets/pregame/start_game_button.dart';
import 'play_input.dart';

/// A page that allows the user to input the number of players.
class PreGamePage extends ConsumerStatefulWidget {
  /// Creates a new [PreGamePage] instance.
  const PreGamePage({super.key});

  @override
  ConsumerState<PreGamePage> createState() => _PreGamePageState();
}

class _PreGamePageState extends ConsumerState<PreGamePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final preGameController = ref.read(preGameProvider.notifier);
      preGameController.initializeControllers();
      preGameController.clearSelectedPlayers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final preGameState = ref.watch(preGameProvider);
    final preGameController = ref.read(preGameProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      preGameController.fetchKnownPlayers();

      if (preGameState.canNavigate) {
        preGameController.resetNavigation();
        final names = preGameController.playerNames;
        ref.read(activeGameProvider.notifier).startGame(names);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PlayInputPage(),
          ),
        ).then((_) {
          preGameController.initializeControllers();
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Game'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              PlayerCountControl(),
              PlayerSelectionChips(),
              Wrap(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Select a player to add them to the game. Enter a name below to add someone new.',
                    ),
                  ),
                ],
              ),
              PlayerInputFields(),
              StartGameButton(
                formKey: _formKey,
                onPressed: preGameController.startGame,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
