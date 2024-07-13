import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/single_player_history_page_controller.dart';
import '../widgets/past_game_list.dart';

/// A page that displays a list of all games that a player has played.
class SinglePlayerHistoryPage extends ConsumerStatefulWidget {
  /// The ID of the player whose history is displayed.
  final String playerId;

  /// Creates a new [SinglePlayerHistoryPage] instance.
  const SinglePlayerHistoryPage({required this.playerId, super.key});

  @override
  ConsumerState<SinglePlayerHistoryPage> createState() =>
      _SinglePlayerHistoryPageState();
}

class _SinglePlayerHistoryPageState
    extends ConsumerState<SinglePlayerHistoryPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    Future.microtask(() {
      ref
          .read(singlePlayerHistoryPageControllerProvider.notifier)
          .fetchPlayer(widget.playerId);
      ref
          .read(singlePlayerHistoryPageControllerProvider.notifier)
          .fetchPlayerGames(widget.playerId);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerHistoryState =
        ref.watch(singlePlayerHistoryPageControllerProvider);

    // Update the controller's text when the player's name changes
    if (playerHistoryState.player != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          controller.text = playerHistoryState.player!.name;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.text} History'),
      ),
      body: playerHistoryState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : playerHistoryState.errorMessage != null
              ? Center(child: Text('Error: ${playerHistoryState.errorMessage}'))
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            _showEditNameModal(context);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        SizedBox(width: 10),
                        Text('Player: ${controller.text}'),
                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: playerHistoryState.games.isEmpty
                          ? const Center(
                              child: Text('No past games found.'),
                            )
                          : PastGameList(games: playerHistoryState.games),
                    ),
                  ],
                ),
    );
  }

  Future<void> _showEditNameModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding:
                MediaQuery.of(context).viewInsets + const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Player Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          ref
                              .read(
                                singlePlayerHistoryPageControllerProvider
                                    .notifier,
                              )
                              .updatePlayerName(
                                playerId: widget.playerId,
                                newName: controller.text.trim(),
                              );
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
