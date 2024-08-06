import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/toast.dart';
import '../../../../edit_settings/presentation/controllers/settings_controller.dart';
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
  Timer? _timer;
  int timerDuration = 0;
  int remainingTime = 0;
  bool canUndo = false;
  bool canSubmit = false;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _initializeTimer() {
    final duration = ref.read(Settings.timerDurationProvider) ?? 0;
    setState(() {
      timerDuration = duration;
      remainingTime = duration;
    });
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      remainingTime = timerDuration;
    });
    _startTimer();
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
    final wordCheckEnabled = ref.watch(Settings.isWordCheckProvider);

    if (wordCheckEnabled) {
      final isValid =
          await ref.read(activeGameProvider.notifier).isValidWord(value);

      if (!isValid) {
        if (RegExp(' ').allMatches(value).length > 2) {
          if (!context.mounted) return;
          // ignore: use_build_context_synchronously
          ToastService.error(context, 'Too many blank tiles!');
        } else {
          if (!context.mounted) return;
          // ignore: use_build_context_synchronously
          ToastService.error(context, '$value is not a valid word.');
        }
        return;
      }
    }
    ref.read(activeGameProvider.notifier).addWordToCurrentPlay(value);
    _textController.clear();
    setState(() {
      canSubmit = false;
    });
  }

  /// Ends the current turn and advances to the next player.
  /// If the input field is not empty, the word is submitted before ending the turn.
  Future<void> _handleEndTurn() async {
    if (_textController.text.isNotEmpty) {
      await _handleWordSubmit(_textController.text).then((_) {
        if (_textController.text.isEmpty) {
          ref.read(activeGameProvider.notifier).endTurn();
        }
      });
    } else {
      ref.read(activeGameProvider.notifier).endTurn();
    }
    if (ref.read(activeGameProvider).plays.isNotEmpty) {
      setState(() {
        canUndo = true;
      });
    }

    if (ref.read(Settings.isTimerEnabledProvider)) {
      if (ref.read(Settings.timerDurationProvider) != null) {
        setState(() {
          timerDuration = ref.read(Settings.timerDurationProvider)!;
        });
      }
    }

    FocusManager.instance.primaryFocus?.unfocus();
    _resetTimer();
  }

  void _handleUndoTurn() {
    ref.read(activeGameProvider.notifier).undoTurn();
    if (ref.read(activeGameProvider).plays.isEmpty) {
      setState(() {
        canUndo = false;
      });
    }
    if (ref.read(Settings.isTimerEnabledProvider)) {
      if (ref.read(Settings.timerDurationProvider) != null) {
        setState(() {
          timerDuration = ref.read(Settings.timerDurationProvider)!;
        });
      }
    }
    _resetTimer();
  }

  void _handleWordUpdate(String value) {
    if (value.isNotEmpty) {
      setState(() {
        canSubmit = true;
      });
      _scrollToEnd();
    } else {
      setState(() {
        canSubmit = false;
      });
    }

    ref.read(activeGameProvider.notifier).updateCurrentWord(value);
  }

  @override
  Widget build(BuildContext context) {
    final gameNotifier = ref.read(activeGameProvider.notifier);
    final game = ref.watch(activeGameProvider);
    final timerDuration = ref.watch(Settings.timerDurationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (timerDuration != null)
          Column(
            children: <Widget>[
              remainingTime == 0
                  ? Text(
                      'Time\'s up!',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  : Text(
                      '$remainingTime seconds remaining',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(
                  value: remainingTime / timerDuration,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TurnHUD(),
            SizedBox(width: 16.0),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: game.currentWord != null
                    ? ScrabbleWordWidget(
                        key: ValueKey(game.currentWord),
                        game.currentWord!,
                        (index) => gameNotifier.toggleScoreMultiplier(
                          game.currentWord!,
                          index,
                        ),
                      )
                    : const SizedBox.shrink(),
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
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
            ],
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
              icon: (_textController.text.isEmpty &&
                      game.currentPlay!.playedWords.isEmpty)
                  ? Icon(Icons.skip_next, semanticLabel: 'Skip turn')
                  : Icon(Icons.redo, semanticLabel: 'End turn and submit word'),
            ),
          ],
        ),
      ],
    );
  }
}
