import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/toast.dart';
import '../../../../history/domain/models/player.dart';
import '../../controllers/pre_game_controller.dart';

/// Displays a row of filter chips for selecting players.
class PlayerSelectionChips extends ConsumerWidget {
  /// Creates a new [PlayerSelectionChips] instance.
  const PlayerSelectionChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.watch(preGameProvider).knownPlayers;

    void handleOnSelect(
      BuildContext context,
      Player player,
      bool selected,
    ) {
      final notifier = ref.read(preGameProvider.notifier);

      if (selected) {
        // Check if the player is already in the game.
        final playerNames = ref.watch(preGameProvider.notifier).playerNames;
        if (playerNames.contains(player.name)) {
          ToastService.error(
            context,
            '${player.name} is already in the game',
          );
          return;
        }

        // Check if the text fields already have this name.
        final controllers = ref.watch(preGameProvider).controllers;
        for (var i = 0; i < controllers.length; i++) {
          if (controllers[i].text == player.name) {
            ToastService.error(
              context,
              '${player.name} is already in the game',
            );
            return;
          }
        }

        // Set the player name in the first empty or active field.
        final activeFieldIndex = ref.watch(preGameProvider).activeFieldIndex;
        if (activeFieldIndex == null) {
          for (var i = 0; i < controllers.length; i++) {
            if (controllers[i].text.isEmpty) {
              notifier.setActiveField(i);
              notifier.updatePlayerName(i, player.name);
              break;
            }
          }
        } else {
          notifier.updatePlayerName(activeFieldIndex, player.name);
        }

        ToastService.message(
          context,
          '${player.name} added to game',
        );
      } else {
        ToastService.message(
          context,
          '${player.name} removed from game',
        );
      }
    }

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: players.isEmpty
          ? Column(
              children: const <Widget>[
                Text('No games found.'),
                Text('Play a game to track players!'),
                SizedBox(height: 20),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: players.map((player) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: Text(player.name),
                        onSelected: (bool selected) =>
                            handleOnSelect(context, player, selected),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }
}
