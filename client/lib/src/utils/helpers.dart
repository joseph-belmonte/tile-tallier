import 'dart:ui';

import 'package:flutter/material.dart';

import '../../enums/score_multipliers.dart';
import '../../enums/scrabble_edition.dart';
import '../features/play_game/domain/models/letter.dart';

import '../theme/theming.dart';

/// Accepts a [ScoreMultiplier] and returns the text to display.
String getMultiplierText(ScoreMultiplier multiplier) {
  switch (multiplier) {
    case ScoreMultiplier.none:
      return '1x';
    case ScoreMultiplier.doubleLetter:
      return '2x';
    case ScoreMultiplier.tripleLetter:
      return '3x';
    default:
      throw Exception('Invalid multiplier: $multiplier');
  }
}

/// Returns the color to use for the tile.
Color getTileColor(Letter letter, ScrabbleEdition edition) {
  return colors[edition]![letter.scoreMultiplier]!;
}
