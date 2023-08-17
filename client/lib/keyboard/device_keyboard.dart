import 'package:flutter/material.dart';

import '../writing_zone.dart';

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
