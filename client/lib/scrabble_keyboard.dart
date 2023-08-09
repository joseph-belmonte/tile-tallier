import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_key.dart';

class ScrabbleKeyboardState extends ChangeNotifier {
  String _typedText = '';

  String get typedText => _typedText;

  void type(String letter) {
    if (letter == '<') {
      if (_typedText.length > 0) {
        _typedText = _typedText.substring(0, _typedText.length - 1);
      }
    } else {
      _typedText += letter;
    }
    notifyListeners();
  }
}

class ScrabbleKeyboard extends StatelessWidget {
  final List<String> keyboardRows = ['QWERTYUIOP', 'ASDFGHJKL', '_ZXCVBNM<'];

  @override
  Widget build(BuildContext context) {
    final keyboardState = Provider.of<ScrabbleKeyboardState>(context);

    return Column(
      children: keyboardRows.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.split('').map((letter) {
            return ScrabbleKey(letter);
          }).toList(),
        );
      }).toList(),
    );
  }
}
