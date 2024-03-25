import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/active_game.dart';
import '../../widgets/display_zone.dart';

import '../../widgets/writing_zone.dart';
import '../home.dart';
import '../post_game/end_game.dart';

/// A page that allows the user to input the scores of the players.
class PlayInputPage extends ConsumerStatefulWidget {
  /// Creates a new [PlayInputPage] instance.
  const PlayInputPage({super.key});

  @override
  ConsumerState<PlayInputPage> createState() => _PlayInputPageState();
}

class _PlayInputPageState extends ConsumerState<PlayInputPage> {
  bool displayScores = true;

  Future<bool?> showQuitDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quit Game'),
          content: const Text('Are you sure you want to quit the game?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement<void, void>(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool willPop) async {
        if (willPop) return;
        final navigator = Navigator.of(context);
        final shouldPop = await showQuitDialog(context);
        if (shouldPop != null) {
          if (shouldPop && navigator.canPop()) navigator.pop();
        } else {
          // Dialog was dismissed without a choice (user tapped outside).
          // No action needed, user continues in the game.
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Play Input'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton.filled(
                    onPressed: () => setState(() => displayScores = !displayScores),
                    icon: displayScores ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                  ),
                  IconButton.filled(
                    icon: Icon(Icons.trending_flat),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EndGamePage(game: ref.read(activeGameProvider)),
                        ),
                      );
                    },
                  ),
                ],
              ),
              PlayerScoreCards(),
              WritingZone(),
            ],
          ),
        ),
      ),
    );
  }
}
