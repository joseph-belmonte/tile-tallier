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
    final activePlay = Provider.of<ActivePlay>(context, listen: false);
    return Selector<ActivePlay, PlayedWord>(
      selector: (_, activePlay) => activePlay.playedWord,
      builder: (context, _, __) => TextField(
        controller: TextEditingController(text: activePlay.playedWord.word),
        onChanged: activePlay.updatePlayedWord,
        onSubmitted: (value) {
          activePlay.playWord(context);
          TextEditingController().clear();
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
  const ButtonKeyboard({super.key});
  static const List<String> keyboardRows = [
    'QWERTYUIOP',
    'ASDFGHJKL',
    '_ ZXCVBNM<', // The '_' = return key, '<' = backspace key
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: keyboardRows
            .map(
              (row) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row.split('').map((letter) => KeyboardKey(letter)).toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}

class KeyboardKey extends StatelessWidget {
  const KeyboardKey(this.character, {super.key});
  final String character;

  Widget get icon {
    if (character == '_') return Icon(Icons.keyboard_return);
    if (character == '<') return Icon(Icons.backspace);
    if (character == ' ') return Icon(Icons.space_bar);
    return Text(character, style: const TextStyle(fontSize: 20));
  }

  void Function() getOnTapBehavior(BuildContext context) {
    var playedWordState = Provider.of<ActivePlay>(context, listen: false);
    if (character == '_') return () => playedWordState.playWord(context);
    if (character == '<') return () => playedWordState.removeLetter();
    return () => playedWordState.playLetter(character);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getOnTapBehavior(context),
      child: Container(padding: const EdgeInsets.all(10), child: icon),
    );
  }
}
