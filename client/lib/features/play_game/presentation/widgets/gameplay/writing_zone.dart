import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/active_game.dart';

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
  Future<void> _handleWordSubmit(String value) async {
    final isValid = await ref.read(activeGameProvider.notifier).isValidWord(value);

    if (isValid) {
      ref.read(activeGameProvider.notifier).addWordToCurrentPlay(value);
      _textController.clear();
    } else {
      if (RegExp(' ').allMatches(value).length > 2) {
        _showInvalidWordSnackBar('Too many blank tiles!');
      } else {
        _showInvalidWordSnackBar('$value is not a valid word.');
      }
      return;
    }
  }

  void _showInvalidWordSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  /// Ends the current turn and advances to the next player.
  /// If the input field is not empty, the word is submitted before ending the turn.
  Future<void> _handleEndTurn() async {
    if (_textController.text.isNotEmpty) {
      await _handleWordSubmit(_textController.text).then((_) {
        if (_textController.text.isEmpty) ref.read(activeGameProvider.notifier).endTurn();
      });
    } else {
      ref.read(activeGameProvider.notifier).endTurn();
    }
    if (ref.read(activeGameProvider).plays.isNotEmpty) {
      canUndo = true;
    }
    FocusManager.instance.primaryFocus?.unfocus();
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
            TurnHUD(),
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
              onPressed: canSubmit
                  ? () async {
                      _handleWordSubmit(_textController.text);
                    }
                  : null,
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
