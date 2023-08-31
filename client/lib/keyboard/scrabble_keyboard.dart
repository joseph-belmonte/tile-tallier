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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: keyboardRows.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                row.split('').map((letter) => ScrabbleKey(letter)).toList(),
          );
        }).toList(),
      ),
    );
  }
}

class ScrabbleKey extends StatelessWidget {
  final String value;

  const ScrabbleKey(this.value, {super.key});

  Widget get icon {
    if (value == '_') return Icon(Icons.keyboard_return);
    if (value == '<') return Icon(Icons.backspace);
    return Text(value, style: const TextStyle(fontSize: 20));
  }

  void Function() getOnTapBehavior(BuildContext context) {
    var playedWordState = Provider.of<CurrentPlayState>(context, listen: false);
    if (value == '_') return () => playedWordState.playWord(context);
    if (value == '<') return () => playedWordState.removeLetter();
    return () => playedWordState.playLetter(value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getOnTapBehavior(context),
      child: Container(padding: const EdgeInsets.all(10), child: icon),
    );
  }
}
