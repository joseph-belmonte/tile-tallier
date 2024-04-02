import 'package:flutter/material.dart';

import '../../enums/score_multipliers.dart';
import '../../enums/scrabble_edition.dart';

/// A map of colors for each edition of Scrabble.
const Map<ScrabbleEdition, Map<ScoreMultiplier, Color>> colors = {
  ScrabbleEdition.classic: {
    ScoreMultiplier.none: Colors.amber,
    ScoreMultiplier.doubleLetter: Color(0xffafcbef),
    ScoreMultiplier.tripleLetter: Color(0xff0a8fdf),
    ScoreMultiplier.doubleWord: Color(0xffe5b5b3),
    ScoreMultiplier.tripleWord: Color(0xffea3820),
  },
  ScrabbleEdition.hasbro: {
    ScoreMultiplier.none: Colors.amber,
    ScoreMultiplier.doubleLetter: Color(0x000ff09f),
    ScoreMultiplier.tripleLetter: Color(0x000099ff),
    ScoreMultiplier.doubleWord: Color(0x00ff0000),
    ScoreMultiplier.tripleWord: Color(0x00ff9900),
  },
};
