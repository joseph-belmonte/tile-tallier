import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/active_game.dart';
import '../../presentation/widgets/display_zone.dart';

import '../../presentation/widgets/writing_zone.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
