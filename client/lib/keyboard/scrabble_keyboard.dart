import 'package:flutter/material.dart';

import '../writing_zone.dart';

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

  ScrabbleKey(String value, this.writingZoneState, {super.key}) {
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
