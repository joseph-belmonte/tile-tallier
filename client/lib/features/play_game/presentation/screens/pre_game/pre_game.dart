import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../application/providers/active_game.dart';
import '../../../domain/models/game.dart';
import '../../../domain/models/play.dart';
import '../during_game/play_input.dart';

/// A page that allows the user to input the number of players
class PreGamePage extends StatefulWidget {
  /// Creates a new [PreGamePage] instance.
  const PreGamePage({super.key});

  @override
  State<PreGamePage> createState() => _PreGamePageState();
}

class _PreGamePageState extends State<PreGamePage> {
  int playerCount = 2;
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = [];
  bool add = true;
  bool remove = false;

  void _updateControllers() {
    final neededControllers = playerCount - _controllers.length;
    if (neededControllers > 0) {
      for (var i = 0; i < neededControllers; i++) {
        _controllers.add(TextEditingController());
      }
    } else if (neededControllers < 0) {
      _controllers.getRange(playerCount, _controllers.length).forEach((c) => c.dispose());
      _controllers.removeRange(playerCount, _controllers.length);
    }
  }

  void startGame() {
    if (_formKey.currentState!.validate()) {
      final playerNames = _controllers
          .map((controller) => controller.text.trim())
          .where((name) => name.isNotEmpty)
          .toList();

      if (playerNames.isNotEmpty) {
        final activeGameNotifier = ActiveGameNotifier(
          Game(
            id: Uuid().v4(),
            currentPlay: Play(timestamp: DateTime.now()),
          ),
        );
        activeGameNotifier.setPlayers(playerNames);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderScope(
              overrides: [
                activeGameProvider.overrideWith((_) => activeGameNotifier),
              ],
              child: PlayInputPage(),
            ),
          ),
        );
      }
    }
  }

  void addPlayer() {
    setState(() {
      if (playerCount < 4) playerCount++;
      if (playerCount == 4) add = false;
      if (playerCount > 2) remove = true;
    });
  }

  void removePlayer() {
    setState(() {
      if (playerCount > 2) playerCount--;
      if (playerCount == 2) remove = false;
      if (playerCount < 4) add = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateControllers(); // Ensure controllers match player count

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Game'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, semanticLabel: 'remove player'),
                      onPressed: playerCount > 2 ? () => setState(() => playerCount--) : null,
                    ),
                    Text('$playerCount Players', style: TextStyle(fontSize: 20)),
                    IconButton(
                      icon: Icon(Icons.add, semanticLabel: 'add player'),
                      onPressed: playerCount < 4 ? () => setState(() => playerCount++) : null,
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: playerCount,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                  child: TextFormField(
                    controller: _controllers[index],
                    decoration: InputDecoration(labelText: 'Player ${index + 1} Name'),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty) ? 'Please enter a name' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton.icon(
                  onPressed: startGame,
                  icon: const Icon(Icons.play_arrow_rounded, semanticLabel: 'start game'),
                  label: const Text('Start Game'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
