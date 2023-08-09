import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';
import 'package:scrabble_scorer/scrabble_keyboard.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ScrabbleKeyboardState(),
    child: ScrabbleScorer(),
  ));
}
