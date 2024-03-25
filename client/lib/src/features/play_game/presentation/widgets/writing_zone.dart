import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/helpers.dart';
import '../../application/providers/active_game.dart';

import 'scrabble_word.dart';

/// A widget that allows the user to play a word.
class WritingZone extends ConsumerStatefulWidget {
  /// Creates a new WritingZone instance.
  const WritingZone({super.key});

  @override
  ConsumerState<WritingZone> createState() => _WritingZoneState();
}

class _WritingZoneState extends ConsumerState<WritingZone> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  /// Submits the word in the input field to the active play.
  void _handleWordSubmit(String value) {
    ref.read(activeGameProvider.notifier).addWordToCurrentPlay(value);
    _textController.clear();
  }

  /// Clears the word in the input field and ends the current turn.
  void _handleEndTurn() {
    _textController.clear();
    ref.read(activeGameProvider.notifier).endTurn();
  }

  @override
  Widget build(BuildContext context) {
    final gameNotifier = ref.read(activeGameProvider.notifier);
    final game = ref.watch(activeGameProvider);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Play Score:'),
                Text(game.currentPlay.score.toString()),
              ],
            ),
            Column(
              children: <Widget>[
                Text('Played Words:'),
                Text(game.currentPlay.playedWords.map((word) => word.word).join(', ')),
              ],
            ),
            Column(
              children: <Widget>[
                Text('Bingo:'),
                IconButton(
                  onPressed: gameNotifier.toggleBingo,
                  icon: game.currentPlay.isBingo ? Icon(Icons.star) : Icon(Icons.star_border),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text('Multiplier:'),
                OutlinedButton.icon(
                  onPressed: gameNotifier.toggleCurrentWordMultiplier,
                  icon: Icon(Icons.multiple_stop_rounded),
                  label: Text(
                    getMultiplierText(game.currentWord.wordMultiplier),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton.filled(
                  onPressed: gameNotifier.undoTurn,
                  icon: Icon(Icons.undo),
                ),
                IconButton.filled(
                  onPressed: () => _handleWordSubmit(ref.read(activeGameProvider).currentWord.word),
                  icon: Icon(Icons.playlist_add),
                ),
                IconButton.filled(
                  onPressed: _handleEndTurn,
                  icon: Icon(Icons.redo),
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
                ScrabbleWordWidget(
                  game.currentWord,
                  (index) => gameNotifier.toggleLetterMultiplier(game.currentWord, index),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text('Word Score: '),
                Text(game.currentWord.score.toString()),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textController,
                onChanged: (value) =>
                    ref.read(activeGameProvider.notifier).updateCurrentWord(value),
                onSubmitted: _handleWordSubmit,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Play a word',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z ]'),
                  ),
                ],
                textCapitalization: TextCapitalization.characters,
                autocorrect: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
