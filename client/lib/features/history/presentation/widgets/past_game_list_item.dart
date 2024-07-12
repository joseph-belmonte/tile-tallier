import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/toast.dart';
import '../../../core/domain/models/game.dart';
import '../controllers/history_page_controller.dart';
import '../screens/past_game.dart';

/// A widget that displays one past game in a dismissible list.
class PastGameListItem extends ConsumerWidget {
  // ignore: public_member_api_docs
  const PastGameListItem({
    required this.game,
    super.key,
  });

  /// The game to display.
  final Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playCount = game.plays.length;
    final date =
        game.plays[playCount - 1].timestamp.toLocal().toString().split(' ')[0];

    final playerScores = game.players
        .map((player) => '${player.name}: ${player.score}')
        .join(', ');

    return Dismissible(
      key: Key(game.id),
      onDismissed: (direction) {
        ref.read(historyPageControllerProvider.notifier).deleteGame(game.id);
        ToastService.message(context, 'Game deleted successfully!');
      },
      direction: DismissDirection.startToEnd,
      background: Container(color: Colors.red),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Theme.of(context).listTileTheme.tileColor,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Game on $date'),
              subtitle: Text(playerScores),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_rounded),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PastGameScreen(gameId: game.id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
