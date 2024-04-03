import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/active_game.dart';

import 'scrabble_word.dart';
import 'turn_hud.dart';

/// A widget that allows the user to play a word.
class WritingZone extends ConsumerStatefulWidget {
  /// Creates a new WritingZone instance.
  const WritingZone({super.key});

  @override
  ConsumerState<WritingZone> createState() => _WritingZoneState();
}

class _WritingZoneState extends ConsumerState<WritingZone> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  bool canUndo = false;
  bool canSubmit = false;

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Submits the word in the input field to the active play.
  void _handleWordSubmit(String value) {
    if (value.isEmpty) {
      canSubmit = false;
      return;
    } else {
      canSubmit = true;
      ref.read(activeGameProvider.notifier).addWordToCurrentPlay(value);
      _textController.clear();
    }
  }

  /// Ends the current turn and advances to the next player.
  /// If the input field is not empty, the word is submitted before ending the turn.
  void _handleEndTurn() {
    if (_textController.text.isNotEmpty) {
      _handleWordSubmit(_textController.text);
    }
    _textController.clear();
    ref.read(activeGameProvider.notifier).endTurn();
    if (ref.read(activeGameProvider).plays.isNotEmpty) {
      canUndo = true;
    }
  }

  void _handleUndoTurn() {
    ref.read(activeGameProvider.notifier).undoTurn();
    if (ref.read(activeGameProvider).plays.isEmpty) {
      canUndo = false;
    }
  }

  void _handleWordUpdate(String value) {
    if (value.isNotEmpty) {
      canSubmit = true;
      _scrollToEnd();
    } else if (value.isEmpty) {
      canSubmit = false;
    }

    ref.read(activeGameProvider.notifier).updateCurrentWord(value);
  }

  @override
  Widget build(BuildContext context) {
    final gameNotifier = ref.read(activeGameProvider.notifier);
    final game = ref.watch(activeGameProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TurnHUD(game: game, gameNotifier: gameNotifier),
            SizedBox(width: 16.0),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: ScrabbleWordWidget(
                  key: ValueKey(game.currentWord),
                  game.currentWord,
                  (index) => gameNotifier.toggleScoreMultiplier(game.currentWord, index),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _textController,
            onChanged: _handleWordUpdate,
            onSubmitted: _handleWordSubmit,
            decoration: InputDecoration(
              labelText: 'Play a word',
              border: OutlineInputBorder(),
            ),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))],
            textCapitalization: TextCapitalization.characters,
            autocorrect: false,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              onPressed: canUndo ? _handleUndoTurn : null,
              icon: Icon(Icons.undo, semanticLabel: 'Undo last turn'),
            ),
            IconButton(
              onPressed: canSubmit ? () => _handleWordSubmit(_textController.text) : null,
              icon: Icon(Icons.playlist_add, semanticLabel: 'Submit word'),
            ),
            IconButton(
              onPressed: _handleEndTurn,
              icon: (_textController.text.isEmpty && game.currentPlay.playedWords.isEmpty)
                  ? Icon(Icons.skip_next, semanticLabel: 'Skip turn')
                  : Icon(Icons.redo, semanticLabel: 'End turn and submit word'),
            ),
          ],
        ),
      ],
    );
  }
}
