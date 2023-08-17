import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'device_keyboard.dart';
import 'keyboard_toggler.dart';
import 'scrabble_keyboard.dart';

class KeyboardWidgetState extends ChangeNotifier {
  static const scrabbleKeyboard = ScrabbleKeyboard();
  static const deviceKeyboard = DeviceKeyboard();
  Widget keyboardWidget = scrabbleKeyboard;

  void toggleKeyboard() {
    if (keyboardWidget == scrabbleKeyboard) {
      keyboardWidget = deviceKeyboard;
    } else {
      keyboardWidget = scrabbleKeyboard;
    }
    notifyListeners();
  }
}

class KeyboardWidget extends StatefulWidget {
  const KeyboardWidget({super.key});

  @override
  State<KeyboardWidget> createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget> {
  @override
  Widget build(BuildContext context) {
    var keyboardWidgetState = Provider.of<KeyboardWidgetState>(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          KeyboardToggler(),
          keyboardWidgetState.keyboardWidget,
        ],
      ),
    );
  }
}
