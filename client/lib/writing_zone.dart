import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_letterbox.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';

import './data/letter_scores.dart';

class WritingZone extends StatefulWidget {
  const WritingZone({super.key});

  @override
  State<WritingZone> createState() => WritingZoneState();
}

class WritingZoneState extends State<WritingZone> {
  late final ScrabbleKeyboard scrabbleKeyboard;
  late final DeviceKeyboard deviceKeyboard;
  late Widget keyboardWidget;
  String _currentWord = '';

  WritingZoneState() {
    scrabbleKeyboard = ScrabbleKeyboard(this);
    deviceKeyboard = DeviceKeyboard(this);
    keyboardWidget = scrabbleKeyboard;
  }

  String get currentWord => _currentWord;
  set currentWord(String word) => setState(() => _currentWord = word);

  int get currentWordScore {
    int score = 0;
    for (var char in currentWord.split('')) {
      score += letterScores[char.toUpperCase()] ?? 0;
    }
    return score;
  }

  void toggleKeyboard() {
    setState(() => keyboardWidget =
        keyboardWidget == scrabbleKeyboard ? deviceKeyboard : scrabbleKeyboard);
  }

  void submitCurrentWord() {
    Provider.of<GameStateNotifier>(context, listen: false).addWord(currentWord);
    currentWord = '';
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Word Score: $currentWordScore', // Display current word score
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var char in currentWord.toUpperCase().split(''))
                GestureDetector(
                  onTap: () => print('Letter $char tapped'),
                  child: ScrabbleLetterbox(char),
                ),
            ],
          ),
          // Contains miscellaneous logic that helps us debug stuff.
          StupidPinkBar(this),
          keyboardWidget,
        ],
      ),
    );
  }
}

/// A stupid pink bar that displays stuff. Currently it just contains
/// a toggle button that changes the keyboard display.
class StupidPinkBar extends StatelessWidget {
  final WritingZoneState writingZoneState;

  const StupidPinkBar(this.writingZoneState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink.shade200,
      padding: EdgeInsets.all(5),
      width: double.infinity,
      child: KeyboardToggler(writingZoneState),
    );
  }
}

class KeyboardToggler extends StatefulWidget {
  final WritingZoneState writingZoneState;

  const KeyboardToggler(this.writingZoneState, {super.key});

  @override
  State<KeyboardToggler> createState() =>
      _KeyboardTogglerState(writingZoneState);
}

class _KeyboardTogglerState extends State<KeyboardToggler> {
  final WritingZoneState writingZoneState;
  bool switchState = false;

  _KeyboardTogglerState(this.writingZoneState);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
          value: switchState,
          onChanged: (value) {
            writingZoneState.toggleKeyboard();
            switchState = value;
          },
        ),
        Text('Change Keyboard', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}

class DeviceKeyboard extends StatelessWidget {
  final _textController = TextEditingController();
  final WritingZoneState writingZoneState;

  DeviceKeyboard(this.writingZoneState, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      onChanged: (value) => writingZoneState.currentWord = value,
      onSubmitted: (value) {
        writingZoneState.submitCurrentWord();
        _textController.clear();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter a word',
      ),
    );
  }
}

class ScrabbleKeyboard extends StatelessWidget {
  static const List<String> keyboardRows = [
    'QWERTYUIOP',
    'ASDFGHJKL',
    '_ZXCVBNM<',
  ];
  final WritingZoneState writingZoneState;

  const ScrabbleKeyboard(this.writingZoneState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: keyboardRows.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row
              .split('')
              .map((letter) => ScrabbleKey(letter, writingZoneState))
              .toList(),
        );
      }).toList(),
    );
  }
}

class ScrabbleKey extends StatelessWidget {
  final WritingZoneState writingZoneState;
  late final void Function() onTap;
  late final Widget icon;

  ScrabbleKey(value, this.writingZoneState, {super.key}) {
    if (value == '_') {
      icon = Icon(Icons.keyboard_return);
      onTap = writingZoneState.submitCurrentWord;
    } else if (value == '<') {
      icon = Icon(Icons.backspace);
      onTap = backspace;
    } else {
      icon = Text(value, style: const TextStyle(fontSize: 20));
      onTap = () => writingZoneState.currentWord += value;
    }
  }

  void backspace() {
    if (writingZoneState.currentWord.isNotEmpty) {
      writingZoneState.currentWord = writingZoneState.currentWord
          .substring(0, writingZoneState.currentWord.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(padding: const EdgeInsets.all(10), child: icon),
    );
  }
}
