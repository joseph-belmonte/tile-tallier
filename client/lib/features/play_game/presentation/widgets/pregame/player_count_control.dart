// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/pre_game_controller.dart';

/// A control for changing the number of players.
class PlayerCountControl extends ConsumerWidget {
  const PlayerCountControl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove, semanticLabel: 'remove player'),
            onPressed: ref.read(preGameProvider).canRemove
                ? ref.read(preGameProvider.notifier).removePlayer
                : null,
          ),
          Text(
            '${ref.read(preGameProvider).playerCount} Players',
            style: const TextStyle(fontSize: 20),
          ),
          IconButton(
            icon: const Icon(Icons.add, semanticLabel: 'add player'),
            onPressed: ref.read(preGameProvider).canAdd
                ? ref.read(preGameProvider.notifier).addPlayer
                : null,
          ),
        ],
      ),
    );
  }
}
