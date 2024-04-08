import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/active_game.dart';
import '../widgets/gameplay/historical_play.dart';
import '../widgets/gameplay/quit_alert_dialogue.dart';
import '../widgets/gameplay/score_subtraction_modal.dart';
import '../widgets/gameplay/writing_zone.dart';

/// A page that allows the user to input the scores of the players.
class PlayInputPage extends ConsumerWidget {
  /// Creates a new [PlayInputPage] instance.
  const PlayInputPage({super.key});

  Future<bool?> _showQuitDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => QuitGameAlert(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool willPop) async {
        if (willPop) return;
        final navigator = Navigator.of(context);
        final shouldPop = await _showQuitDialog(context);
        if (shouldPop != null) {
          if (shouldPop && navigator.canPop()) navigator.pop();
        } else {
          // Dialog was dismissed without a choice (user tapped outside).
          // No action needed, user continues in the game.
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Game View'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.flag_rounded, semanticLabel: 'End Game'),
              onPressed: () => showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (context) => ScoreSubtractionModal(),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ref.read(activeGameProvider).players.isEmpty
                  ? const LinearProgressIndicator()
                  : const SizedBox.shrink(),
              Expanded(
                child: ListView.builder(
                  itemCount: ref.watch(activeGameProvider).plays.length,
                  itemBuilder: (_, int i) {
                    final player = ref.watch(activeGameProvider).players.firstWhere(
                          (player) => player.id == ref.watch(activeGameProvider).plays[i].playerId,
                        );
                    return HistoricalPlay(
                      key: ValueKey(ref.read(activeGameProvider).plays[i]),
                      player: player,
                      play: ref.watch(activeGameProvider).plays[i],
                      i,
                    );
                  },
                ),
              ),
              Divider(),
              SizedBox(height: 8),
              WritingZone(),
            ],
          ),
        ),
      ),
    );
  }
}
