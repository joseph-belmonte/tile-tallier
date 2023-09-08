import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'writing_zone.dart';

enum KeyboardType { button, device }

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  Consumer<AppState> get keyboardWidget {
    return Consumer<AppState>(
      builder: (_, appState, child) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appState.keyboardType == KeyboardType.button ? ButtonKeyboard() : DeviceKeyboard(),
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

    // make sure the cursor is always at the end of the text field (to avoid
    // weird behavior when the user edits the middle of the word)
    textController.addListener(() {
      int offset = textController.text.length;
      textController.selection = TextSelection.collapsed(offset: offset);
    });

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
        ],
      ),
    );
  }
}

class ButtonKeyboard extends StatelessWidget {
  static const List<String> keyboardRows = [
    'QWERTYUIOP',
    'ASDFGHJKL',
    // The '/' is a placeholder for the return key
    // The '<' is a placeholder for the backspace key
    '/ ZXCVBNM<',
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
            children: row.split('').map((letter) => KeyboardKey(letter)).toList(),
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
    if (value == '/') return Icon(Icons.keyboard_return);
    if (value == '<') return Icon(Icons.backspace);
    if (value == ' ') return Icon(Icons.space_bar);
    return Text(value, style: const TextStyle(fontSize: 20));
  }

  void Function() getOnTapBehavior(BuildContext context) {
    var playedWordState = Provider.of<CurrentPlayState>(context, listen: false);
    if (value == '/') return () => playedWordState.playWord(context);
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
