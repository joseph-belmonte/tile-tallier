import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'keyboard.dart';

class KeyboardToggler extends StatefulWidget {
  const KeyboardToggler({super.key});

  @override
  State<KeyboardToggler> createState() => _KeyboardTogglerState();
}

class _KeyboardTogglerState extends State<KeyboardToggler> {
  bool switchState = false;

  @override
  Widget build(BuildContext context) {
    var keyboardWidgetState = Provider.of<KeyboardWidgetState>(context);
    return Container(
      color: Colors.pink.shade200,
      padding: EdgeInsets.all(5),
      width: double.infinity,
      child: Column(
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
      ),
    );
  }
}
