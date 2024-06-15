import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/active_game.dart';

import '../widgets/gameplay/historical_play.dart';
import '../widgets/gameplay/quit_alert_dialogue.dart';
import '../widgets/gameplay/score_subtraction_modal.dart';
import '../widgets/gameplay/writing_zone.dart';

/// A page that allows the user to input the scores of the players.
class PlayInputPage extends ConsumerStatefulWidget {
  /// Creates a new [PlayInputPage] instance.
  const PlayInputPage({super.key});

  @override
  ConsumerState<PlayInputPage> createState() => _PlayInputPageState();
}

class _PlayInputPageState extends ConsumerState<PlayInputPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Example: Simulate list update
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd(); // Initial scroll
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  Future<bool?> _showQuitDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => QuitGameAlert(),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
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
          return;
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
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
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
              SizedBox(height: 8),
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
