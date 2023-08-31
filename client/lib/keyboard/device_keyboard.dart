import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../writing_zone.dart';

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
      ),
    );
  }
}
