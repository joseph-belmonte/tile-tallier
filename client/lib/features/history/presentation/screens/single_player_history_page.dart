import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/player_games_provider.dart';
import '../../application/providers/players_provider.dart';
import '../../domain/models/player.dart';
import '../controllers/history_page_controller.dart';
import '../widgets/edit_name_modal.dart';
import '../widgets/past_game_list.dart';

/// A page that displays a list of all games that a player has played.
class SinglePlayerHistoryPage extends ConsumerStatefulWidget {
  /// The [Player] whose history is displayed.
  final Player player;

  /// Creates a new [SinglePlayerHistoryPage] instance.
  const SinglePlayerHistoryPage({required this.player, super.key});

  @override
  ConsumerState<SinglePlayerHistoryPage> createState() =>
      _PlayerHistoryPageState();
}

class _PlayerHistoryPageState extends ConsumerState<SinglePlayerHistoryPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    // Fetch player data initially to set the controller's text
    fetchPlayerData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> fetchPlayerData() async {
    final player = ref.read(playersProvider).firstWhere(
          (element) => element.id == widget.player.id,
        );
    setState(() {
      controller.text = player.name;
    });
  }

  void updateName(String newName) async {
    await ref.read(historyPageControllerProvider.notifier).updatePlayerName(
          playerId: widget.player.id,
          newName: newName,
        );

    setState(() {
      controller.text = newName;
    });

    await ref.read(historyPageControllerProvider.notifier).fetchPlayers();
    await ref.read(historyPageControllerProvider.notifier).fetchGames();
  }

  Future<void> showEditNameModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return EditNameModal(
          playerId: widget.player.id,
          onSubmitEdit: updateName,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final playerGamesState = ref.watch(playerGamesProvider(widget.player.id));

    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.text} History'),
      ),
      body: playerGamesState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error\n$stackTrace'),
        ),
        data: (games) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      showEditNameModal(context);
                    },
                    icon: Icon(Icons.edit),
                  ),
                  SizedBox(width: 10),
                  Text('Player: ${controller.text}'),
                ],
              ),
              Divider(),
              Expanded(
                child: (games.isEmpty)
                    ? const Center(
                        child: Text('No past games found.'),
                      )
                    : PastGameList(games: games),
              ),
            ],
          );
        },
      ),
    );
  }
}
