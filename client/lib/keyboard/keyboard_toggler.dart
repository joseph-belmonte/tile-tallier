import 'package:flutter/material.dart';

import 'keyboard.dart';

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
