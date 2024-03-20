import 'package:flutter/material.dart';

import 'scrabble_edition.dart';

/// An enum representing the letter score multipliers in Scrabble.
enum LetterScoreMultiplier {
  /// A score multiplier that is the default letter value
  singleLetter(1, '1X'),

  /// A score multiplier that doubles the value of a letter.
  doubleLetter(2, '2X'),

  /// A score multiplier that triples the value of a letter.
  tripleLetter(3, '3X');

  const LetterScoreMultiplier(this.value, this.label);

  /// The value of the score multiplier.
  final int value;

  /// The label for the score multiplier.
  final String label;

  /// A map of colors for each edition of Scrabble.
  static const Map<ScrabbleEdition, Map<LetterScoreMultiplier, Color>> colors = {
    ScrabbleEdition.classic: {
      LetterScoreMultiplier.singleLetter: Colors.amber,
      LetterScoreMultiplier.doubleLetter: Color.fromARGB(255, 123, 213, 241),
      LetterScoreMultiplier.tripleLetter: Color.fromARGB(255, 50, 56, 240),
    },
    ScrabbleEdition.twentyFifthAnniversary: {
      LetterScoreMultiplier.singleLetter: Colors.amber,
      LetterScoreMultiplier.doubleLetter: Color.fromARGB(255, 184, 240, 0),
      LetterScoreMultiplier.tripleLetter: Color.fromARGB(255, 5, 158, 0),
    },
  };

  /// Returns the color for the letter score multiplier based on the edition.
  Color editionColor(ScrabbleEdition edition) => colors[edition]![this]!;
}

/// An enum representing the word score multipliers in Scrabble.
enum WordScoreMultiplier {
  /// A score multiplier that is the default word value
  singleWord(1, '1X'),

  /// A score multiplier that doubles the value of a word.
  doubleWord(2, '2X'),

  /// A score multiplier that triples the value of a word.
  tripleWord(3, '3X');

  const WordScoreMultiplier(this.value, this.label);

  /// The value of the score multiplier.
  final int value;

  /// The label for the score multiplier.
  final String label;

  /// Returns the color for the word score multiplier based on the edition.
  static const Map<ScrabbleEdition, Map<WordScoreMultiplier, Color>> colors = {
    ScrabbleEdition.classic: {
      WordScoreMultiplier.singleWord: Colors.amber,
      WordScoreMultiplier.doubleWord: Color.fromARGB(255, 123, 213, 241),
      WordScoreMultiplier.tripleWord: Color.fromARGB(255, 50, 56, 240),
    },
    ScrabbleEdition.twentyFifthAnniversary: {
      WordScoreMultiplier.singleWord: Colors.amber,
      WordScoreMultiplier.doubleWord: Color.fromARGB(255, 184, 240, 0),
      WordScoreMultiplier.tripleWord: Color.fromARGB(255, 5, 158, 0),
    },
  };

  /// Returns the color for the word score multiplier based on the edition.
  Color editionColor(ScrabbleEdition edition) => colors[edition]![this]!;
}
