import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/toast.dart';
import '../../controllers/pre_game_controller.dart';

/// Displays a row of filter chips for selecting players.
class PlayerSelectionChips extends ConsumerWidget {
  /// Creates a new [PlayerSelectionChips] instance.
  const PlayerSelectionChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.read(preGameProvider).knownPlayers;

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: players.map((player) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilterChip(
              label: Text(player.name),
              onSelected: (selected) {
                if (ref.read(preGameProvider).selectedPlayers.length ==
                    ref.read(preGameProvider).playerCount) {
                  ref.read(preGameProvider.notifier).deselectPlayer(
                        ref.read(preGameProvider).selectedPlayers.first,
                      );
                }

                if (selected) {
                  if (ref
                      .read(preGameProvider)
                      .selectedPlayers
                      .contains(player.name)) {
                    ToastService.error(context, 'Player already selected');
                    return;
                  } else {
                    ref
                        .read(preGameProvider.notifier)
                        .selectPlayer(player.name);
                  }
                } else {
                  ref
                      .read(preGameProvider.notifier)
                      .deselectPlayer(player.name);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
