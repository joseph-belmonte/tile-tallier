import 'package:flutter/material.dart';

import '../writing_zone.dart';
import 'device_keyboard.dart';
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

/// A stupid pink bar that displays stuff. Currently it just contains
/// a toggle button that changes the keyboard display.
class KeyboardTogglerContainer extends StatelessWidget {
  final KeyboardWidgetState keyboardWidgetState;

  const KeyboardTogglerContainer(this.keyboardWidgetState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink.shade200,
      padding: EdgeInsets.all(5),
      width: double.infinity,
      child: KeyboardToggler(keyboardWidgetState),
    );
  }
}

class KeyboardToggler extends StatefulWidget {
  final KeyboardWidgetState keyboardWidgetState;

  const KeyboardToggler(this.keyboardWidgetState, {super.key});

  @override
  State<KeyboardToggler> createState() =>
      _KeyboardTogglerState(keyboardWidgetState);
}

class _KeyboardTogglerState extends State<KeyboardToggler> {
  final KeyboardWidgetState keyboardWidgetState;
  bool switchState = false;

  _KeyboardTogglerState(this.keyboardWidgetState);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
          value: switchState,
          onChanged: (value) {
            keyboardWidgetState.toggleKeyboard();
            switchState = value;
          },
        ),
        Text('Change Keyboard', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
