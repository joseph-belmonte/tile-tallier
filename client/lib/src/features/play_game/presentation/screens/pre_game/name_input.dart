import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/active_game.dart';
import '../../../domain/models/game.dart';
import '../during_game/game_navigator.dart';

/// A page that allows the user to input the names of the players.
class NameInput extends StatefulWidget {
  /// Creates a new [NameInput] instance.
  const NameInput({required int playerCount, super.key}) : _playerCount = playerCount;

  final int _playerCount;

  @override
  State<NameInput> createState() => _NameInputsState();
}

class _NameInputsState extends State<NameInput> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _validPlayerNames = [];
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget._playerCount; i++) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startGame() {
    if (_formKey.currentState!.validate()) {
      _validPlayerNames.clear();
      for (var controller in _controllers) {
        final playerName = controller.text.trim();
        if (playerName.isNotEmpty) {
          _validPlayerNames.add(playerName);
        }
      }

      if (_validPlayerNames.isNotEmpty) {
        final game = Game()..addPlayers(_validPlayerNames);
        final activeGameNotifier = ActiveGameNotifier(game);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderScope(
              overrides: [
                activeGameProvider.overrideWith((_) => activeGameNotifier),
              ],
              child: const GameNavigator(),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter the player names')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerNameInputs = List.generate(
      widget._playerCount,
      (index) => PlayerNameInput(playerNumber: index + 1, controller: _controllers[index]),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Player Names'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ...playerNameInputs,
                ElevatedButton.icon(
                  onPressed: () => _startGame(),
                  icon: Icon(Icons.play_arrow_rounded),
                  label: Text('Start Game'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget that allows the user to input a player's name.
class PlayerNameInput extends StatelessWidget {
  /// Creates a new [PlayerNameInput] instance.
  const PlayerNameInput({
    required int playerNumber,
    required TextEditingController controller,
    super.key,
  })  : _controller = controller,
        _playerNumber = playerNumber;

  final int _playerNumber;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
      child: TextFormField(
        autocorrect: false,
        controller: _controller,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a name';
          }
          return null;
        },
        decoration: InputDecoration(
          label: Text('Player $_playerNumber'),
          hintText: 'Player ${_playerNumber.toString()}',
        ),
      ),
    );
  }
}
