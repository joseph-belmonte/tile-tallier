import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../writing_zone.dart';

class DeviceKeyboard extends StatelessWidget {
  static final _textController = TextEditingController();

  const DeviceKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    var writingZoneState =
        Provider.of<WritingZoneState>(context, listen: false);
    return TextField(
      controller: _textController,
      onChanged: (value) => writingZoneState.currentWord = value,
      onSubmitted: (value) {
        writingZoneState.onSubmitWord(context);
        _textController.clear();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter a word',
      ),
    );
  }
}
