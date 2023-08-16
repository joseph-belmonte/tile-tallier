import 'package:flutter/material.dart';
import 'package:scrabble_scorer/scrabble_key.dart';

class ScrabbleKeyboardState extends ChangeNotifier {
  String typedText = '';

  var wordEntered = false;

  void type(String letter) {
    switch (letter) {
      case '_':
        if (typedText.isNotEmpty) {
          wordEntered = true;
          print('Entered word: $typedText');
        } else {
          print('Nothing to add');
        }
        break;
      case '<':
        if (typedText.isNotEmpty) {
          typedText = typedText.substring(0, typedText.length - 1);
        } else {
          print('Nothing to delete');
        }
        break;
      default:
        typedText += letter;
    }
    notifyListeners();
  }
}

class ScrabbleKeyboard extends StatelessWidget {
  const ScrabbleKeyboard(
      {required this.onTapCallback, required this.onSubmitCallback, Key? key})
      : super(key: key);

  static const List<String> keyboardRows = [
    'QWERTYUIOP',
    'ASDFGHJKL',
    '_ZXCVBNM<'
  ];
  final Function(String) onTapCallback;
  final Function(String) onSubmitCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: keyboardRows.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row
              .split('')
              .map((letter) =>
                  ScrabbleKey(letter, onTapCallback, onSubmitCallback))
              .toList(),
        );
      }).toList(),
    );
  }
}
