// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// A control for changing the number of players.
class PlayerCountControl extends StatelessWidget {
  final int playerCount;
  final bool canAdd;
  final bool canRemove;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const PlayerCountControl({
    required this.playerCount,
    required this.canAdd,
    required this.canRemove,
    required this.onAdd,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove, semanticLabel: 'remove player'),
            onPressed: canRemove ? onRemove : null,
          ),
          Text(
            '$playerCount Players',
            style: const TextStyle(fontSize: 20),
          ),
          IconButton(
            icon: const Icon(Icons.add, semanticLabel: 'add player'),
            onPressed: canAdd ? onAdd : null,
          ),
        ],
      ),
    );
  }
}
