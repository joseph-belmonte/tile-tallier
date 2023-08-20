import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../writing_zone.dart';

class DeviceKeyboard extends StatelessWidget {
  static final _textController = TextEditingController();

  const DeviceKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    var playedWordState = Provider.of<PlayedWordState>(context, listen: false);
    return TextField(
      controller: _textController,
      onChanged: (value) => playedWordState.setPlayedLetters(value),
      onSubmitted: (value) {
        playedWordState.playWord(context);
        _textController.clear();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter a word',
      ),
    );
  }
}
