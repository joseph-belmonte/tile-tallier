import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../utils/helpers.dart';
import '../../application/providers/active_game.dart';

import 'scrabble_word.dart';

final _logger = Logger();

/// A widget that allows the user to play a word.
class WritingZone extends ConsumerStatefulWidget {
  /// Creates a new WritingZone instance.
  const WritingZone({super.key});

  @override
  ConsumerState<WritingZone> createState() => _WritingZoneState();
}

// TODO: have UI update on state change. currently manually refreshing
class _WritingZoneState extends ConsumerState<WritingZone> {
  void _handleWordUpdate(String value) {
    ref.read(activeGameProvider.notifier).updateCurrentWord(value);
  }

  void _handleWordSubmit(String value) {
    ref.read(activeGameProvider.notifier).addWordToCurrentPlay(value);
    TextEditingController().clear();
  }

  @override
  Widget build(BuildContext context) {
    final gameNotifier = ref.read(activeGameProvider.notifier);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Play Score:'),
                Text(ref.read(activeGameProvider).currentPlay.score.toString()),
              ],
            ),
            Column(
              children: <Widget>[
                Text('Bingo:'),
                IconButton(
                  onPressed: () => gameNotifier.toggleBingo(),
                  icon: ref.read(activeGameProvider).currentPlay.isBingo
                      ? Icon(Icons.star)
                      : Icon(Icons.star_border),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text('Multiplier:'),
                OutlinedButton.icon(
                  onPressed: () => gameNotifier.toggleWordMultiplier(),
                  icon: Icon(Icons.multiple_stop_rounded),
                  label: Text(
                    getMultiplierText(ref.read(activeGameProvider).currentWord.wordMultiplier),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton.filled(
                  onPressed: () => _handleWordSubmit(ref.read(activeGameProvider).currentWord.word),
                  icon: Icon(Icons.playlist_add),
                ),
                IconButton.filled(
                  onPressed: () => gameNotifier.endTurn(),
                  icon: Icon(Icons.playlist_add_check),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Current Word: '),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.hardEdge,
                  child: ScrabbleWordWidget(ref.read(activeGameProvider).currentWord),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text('Word Score: '),
                Text(ref.read(activeGameProvider).currentWord.score.toString()),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: TextEditingController(text: ''),
                onChanged: (value) => _handleWordUpdate(value),
                onSubmitted: (value) => _handleWordSubmit(value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Play a word',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z ]'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
