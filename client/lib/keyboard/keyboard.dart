import 'package:flutter/material.dart';

import '../writing_zone.dart';
import 'device_keyboard.dart';
import 'keyboard_toggler.dart';
import 'scrabble_keyboard.dart';

class KeyboardWidget extends StatefulWidget {
  final WritingZoneState writingZoneState;

  const KeyboardWidget(this.writingZoneState, {super.key});

  @override
  State<KeyboardWidget> createState() => KeyboardWidgetState(writingZoneState);
}

class KeyboardWidgetState extends State<KeyboardWidget> {
  late final ScrabbleKeyboard scrabbleKeyboard;
  late final DeviceKeyboard deviceKeyboard;
  late Widget keyboardWidget;

  KeyboardWidgetState(WritingZoneState writingZoneState) {
    scrabbleKeyboard = ScrabbleKeyboard(writingZoneState);
    deviceKeyboard = DeviceKeyboard(writingZoneState);
    keyboardWidget = scrabbleKeyboard;
  }

  void toggleKeyboard() {
    setState(() => keyboardWidget =
        keyboardWidget == scrabbleKeyboard ? deviceKeyboard : scrabbleKeyboard);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          KeyboardTogglerContainer(this),
          keyboardWidget,
        ],
      ),
    );
  }
}
