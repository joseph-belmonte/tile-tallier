import 'package:flutter/material.dart';

import 'name_input.dart';

class PlayerCountInput extends StatefulWidget {
  const PlayerCountInput({super.key});

  @override
  State<PlayerCountInput> createState() => _PlayerCountInputState();
}

class _PlayerCountInputState extends State<PlayerCountInput> {
  int playerCount = 2;
  bool add = true;
  bool remove = false;

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

  void onSubmitCount() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NameInput(playerCount: playerCount),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How many players?'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          const Text(
            'How many players?',
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton.filled(
                onPressed: remove ? () => removePlayer() : null,
                icon: remove
                    ? const Icon(Icons.remove)
                    : const Icon(Icons.remove, color: Colors.grey),
              ),
              SizedBox(width: 50),
              Text(
                playerCount.toString(),
                style: const TextStyle(fontSize: 100),
              ),
              SizedBox(width: 50),
              IconButton.filled(
                onPressed: add ? () => addPlayer() : null,
                icon: add ? const Icon(Icons.add) : const Icon(Icons.add, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            // replace the modal with the name input modal
            onPressed: () => onSubmitCount(),
            icon: const Icon(Icons.supervised_user_circle),
            label: const Text('Names'),
          ),
        ],
      ),
    );
  }
}
