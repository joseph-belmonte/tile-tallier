import 'package:flutter/material.dart';
import 'package:scrabble_scorer/scrabble_key.dart';

class ScrabbleKeyboardState extends ChangeNotifier {
  String typedText = '';

  void type(String letter) {
    if (letter == '<') {
      if (typedText.isNotEmpty) {
        typedText = typedText.substring(0, typedText.length - 1);
      }
    } else {
      typedText += letter;
    }
    notifyListeners();
  }
}

class ScrabbleKeyboard extends StatelessWidget {
  const ScrabbleKeyboard({super.key});

  static const List<String> keyboardRows = [
    'QWERTYUIOP',
    'ASDFGHJKL',
    '_ZXCVBNM<'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: keyboardRows.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.split('').map((letter) => ScrabbleKey(letter)).toList(),
        );
      }).toList(),
    );
  }
}
