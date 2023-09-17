import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/game.dart';
import 'providers/active_play.dart';
import 'providers/app_state.dart';

enum KeyboardType { button, device }

class Keyboard extends StatelessWidget {
  static const deviceKeyboard = DeviceKeyboard();
  static const buttonKeyboard = ButtonKeyboard();
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AppState, KeyboardType>(
      selector: (_, appState) => appState.keyboardType,
      builder: (_, keyboardType, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [keyboardType == KeyboardType.button ? buttonKeyboard : deviceKeyboard],
          ),
        );
      },
    );
  }
}

class DeviceKeyboard extends StatelessWidget {
  const DeviceKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    // ensure the text field is rebuilt when the played word changes
    return Selector<ActivePlay, PlayedWord>(
      selector: (_, activePlay) => activePlay.playedWord,
      builder: (context, __, ___) => _buildTextField(context),
    );
  }

  Widget _buildTextField(BuildContext context) {
    final playState = Provider.of<ActivePlay>(context, listen: false);
    final textController = TextEditingController(text: playState.playedWord.word);

    // make sure the cursor is always at the end of the text field (to avoid
    // weird behavior when the user edits the middle of the word)
    textController.addListener(() {
      textController.selection = TextSelection.collapsed(offset: textController.text.length);
    });

    return Align(
      alignment: Alignment.bottomCenter,
      child: TextField(
        controller: textController,
        onChanged: (value) => playState.updatePlayedWord(value),
        onSubmitted: (value) {
          playState.playWord(context);
          textController.clear();
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Play a word',
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
        ],
      ),
    );
  }
}

class ButtonKeyboard extends StatelessWidget {
  static const List<String> keyboardRows = [
    'QWERTYUIOP',
    'ASDFGHJKL',
    // The '_' is a placeholder for the return key
    // The '<' is a placeholder for the backspace key
    '_ ZXCVBNM<',
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
    if (value == '_') return Icon(Icons.keyboard_return);
    if (value == '<') return Icon(Icons.backspace);
    if (value == ' ') return Icon(Icons.space_bar);
    return Text(value, style: const TextStyle(fontSize: 20));
  }

  void Function() getOnTapBehavior(BuildContext context) {
    var playedWordState = Provider.of<ActivePlay>(context, listen: false);
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
