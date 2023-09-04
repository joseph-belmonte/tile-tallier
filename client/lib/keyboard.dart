import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'scrabble_scorer.dart';
import 'writing_zone.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  Widget get keyboardWidget {
    return Consumer<AppState>(
      builder: (_, appState, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appState.keyboardType == KeyboardType.button
                  ? ButtonKeyboard()
                  : DeviceKeyboard()
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return keyboardWidget;
  }
}

class DeviceKeyboard extends StatelessWidget {
  const DeviceKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    var playedWordState = Provider.of<CurrentPlayState>(context, listen: false);
    final textController = TextEditingController(
      text: playedWordState.playedWord.word,
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: TextField(
        controller: textController,
        onChanged: (value) => playedWordState.updatePlayedWord(value),
        onSubmitted: (value) {
          playedWordState.playWord(context);
          textController.clear();
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Play a word',
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z ]'),
          ),
          FilteringTextInputFormatter.deny(
            RegExp(r'[0-9!@#\$%\^&*(),.?":{}|<>]'),
          ),
        ],
      ),
    );
  }
}

class ButtonKeyboard extends StatelessWidget {
  static const List<String> keyboardRows = [
    'QWERTYUIOP',
    'ASDFGHJKL',
    '_ZXCVBNM<',
  ];

  const ButtonKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: keyboardRows.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                row.split('').map((letter) => KeyboardKey(letter)).toList(),
          );
        }).toList(),
      ),
    );
  }
}

class KeyboardKey extends StatelessWidget {
  final String value;

  const KeyboardKey(this.value, {super.key});

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
