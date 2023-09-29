import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/active_game.dart';
import '../game_view.dart';

class NameInput extends StatefulWidget {
  const NameInput({required this.playerCount, super.key});

  final int playerCount;

  @override
  NameInputsState createState() {
    return NameInputsState();
  }
}

class NameInputsState extends State<NameInput> {
  final _formKey = GlobalKey<FormState>();
  final List<String> validPlayerNames = [];
  final List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.playerCount; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void startGame() {
    if (_formKey.currentState!.validate()) {
      for (var i = 0; i < widget.playerCount; i++) {
        final playerName = controllers[i].text.trim();
        if (playerName.isNotEmpty) {
          validPlayerNames.add(playerName);
        }
      }

      if (validPlayerNames.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter at least one player name')),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => ActiveGame(playerNames: validPlayerNames),
              child: GameView(playerList: validPlayerNames),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter at least one valid name')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerNameInputs = List.generate(
      widget.playerCount,
      (index) => PlayerNameInput(playerNumber: index + 1, controller: controllers[index]),
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
                  onPressed: () => startGame(),
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

class PlayerNameInput extends StatelessWidget {
  const PlayerNameInput({required this.playerNumber, required this.controller, super.key});
  final int playerNumber;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
      child: TextFormField(
        autocorrect: false,
        controller: controller,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a name';
          }
          return null;
        },
        decoration: InputDecoration(
          label: Text('Player $playerNumber'),
          hintText: 'Player ${playerNumber.toString()}',
        ),
      ),
    );
  }
}
