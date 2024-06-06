import 'package:flutter/material.dart';

import '../../enums/score_multipliers.dart';
import '../../enums/scrabble_edition.dart';

/// A map of colors for each edition of Scrabble.
const Map<ScrabbleEdition, Map<ScoreMultiplier, Color>> scrabbleTileColors = {
  ScrabbleEdition.classic: {
    ScoreMultiplier.none: Colors.amber,
    ScoreMultiplier.doubleLetter: Color(0xFFafcbef),
    ScoreMultiplier.tripleLetter: Color(0xFF0a8fdf),
    ScoreMultiplier.doubleWord: Color(0xFFe5b5b3),
    ScoreMultiplier.tripleWord: Color(0xFFea3820),
  },
  ScrabbleEdition.hasbro: {
    ScoreMultiplier.none: Colors.amber,
    ScoreMultiplier.doubleLetter: Color(0xFF00ff09),
    ScoreMultiplier.tripleLetter: Color(0xFF0099ff),
    ScoreMultiplier.doubleWord: Color(0xFFff0000),
    ScoreMultiplier.tripleWord: Color(0xFFff9900),
  },
};
