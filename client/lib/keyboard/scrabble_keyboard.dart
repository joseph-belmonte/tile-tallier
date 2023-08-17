import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../writing_zone.dart';

class ScrabbleKeyboard extends StatelessWidget {
  static const List<String> keyboardRows = [
    'QWERTYUIOP',
    'ASDFGHJKL',
    '_ZXCVBNM<',
  ];

  const ScrabbleKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: keyboardRows.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.split('').map((letter) => ScrabbleKey(letter)).toList(),
        );
      }).toList(),
    );
  }
}

class ScrabbleKey extends StatelessWidget {
  late final void Function(BuildContext) onTap;
  late final Widget icon;
  final String value;

  ScrabbleKey(this.value, {super.key}) {
    if (value == '_') {
      icon = Icon(Icons.keyboard_return);
      onTap = enter;
    } else if (value == '<') {
      icon = Icon(Icons.backspace);
      onTap = backspace;
    } else {
      icon = Text(value, style: const TextStyle(fontSize: 20));
      onTap = type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(padding: const EdgeInsets.all(10), child: icon),
    );
  }

  void type(BuildContext context) {
    var writingZoneState =
        Provider.of<WritingZoneState>(context, listen: false);
    writingZoneState.currentWord += value;
  }

  void backspace(BuildContext context) {
    var writingZoneState =
        Provider.of<WritingZoneState>(context, listen: false);
    if (writingZoneState.currentWord.isNotEmpty) {
      writingZoneState.currentWord = writingZoneState.currentWord
          .substring(0, writingZoneState.currentWord.length - 1);
    }
  }

  void enter(BuildContext context) {
    var writingZoneState =
        Provider.of<WritingZoneState>(context, listen: false);
    writingZoneState.onSubmitWord(context);
  }
}
