import 'package:flutter/material.dart';

import '../theme/constants/scrabble_tile_colors.dart';
import 'scrabble_edition.dart';

/// An enum representing the letter score multipliers in Scrabble.
enum ScoreMultiplier {
  /// A score multiplier that is the default letter value
  none(1, ''),

  /// A score multiplier that doubles the value of a letter.
  doubleLetter(2, '2X'),

  /// A score multiplier that triples the value of a letter.
  tripleLetter(3, '3X'),

  /// A score multiplier that doubles the value of the word this letter is in.
  doubleWord(2, '2X'),

  /// A score multiplier that triples the value of the word this letter is in.
  tripleWord(3, '3X');

  const ScoreMultiplier(this.value, this.label);

  /// The value of the score multiplier.
  final int value;

  /// The label for the score multiplier.
  final String label;

  /// Returns the color for the letter score multiplier based on the edition.
  Color editionColor(ScrabbleEdition edition) =>
      scrabbleTileColors[edition]![this]!;
}
