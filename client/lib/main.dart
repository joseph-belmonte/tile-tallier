import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_scorer/scrabble_scorer.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => GameStateNotifier(),
    child: const ScrabbleScorer(),
  ));
}
