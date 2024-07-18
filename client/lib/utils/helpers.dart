import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../enums/score_multipliers.dart';
import '../enums/scrabble_edition.dart';
import '../features/core/domain/models/letter.dart';

import '../theme/constants/scrabble_tile_colors.dart';

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
  return scrabbleTileColors[edition]![letter.scoreMultiplier]!;
}

/// Returns the icon color for the player at the given index.
Color? getIconColor(int index) {
  switch (index) {
    case 0:
      return Colors.yellow;
    case 1:
      return Color.fromRGBO(192, 192, 192, 1);
    case 2:
      return Colors.brown;
    default:
      return null;
  }
}

/// Generates a list of words with wildcards based on spaces
List<String> generateWildcardWords(String word) {
  final results = <String>{};
  final indices = List<int>.generate(word.length, (i) => i);
  // Identify wildcard positions by spaces
  final wildcardPositions = indices.where((i) => word[i] == ' ').toList();

  if (wildcardPositions.isEmpty) {
    results.add(word);
    return results.toList();
  }

  // Generate all possible words replacing wildcards with 'a' to 'z'
  results.addAll(_replaceWildcards(word, wildcardPositions, 0, ''));

  return results.toList();
}

/// Helper function to replace wildcards recursively
Set<String> _replaceWildcards(
  String word,
  List<int> positions,
  int index,
  String currentPrefix,
) {
  final currentResults = <String>{};
  if (index >= positions.length) {
    // Once all positions are replaced, return the completed word
    return {currentPrefix + word.substring(positions.last + 1)};
  }

  // Current position to replace
  final currentPosition = positions[index];
  final prefix = currentPrefix +
      (index == 0
          ? word.substring(0, currentPosition)
          : word.substring(positions[index - 1] + 1, currentPosition));

  for (var c = 'a'.codeUnitAt(0); c <= 'z'.codeUnitAt(0); c++) {
    currentResults.addAll(
      _replaceWildcards(
        word,
        positions,
        index + 1,
        prefix + String.fromCharCode(c),
      ),
    );
  }

  return currentResults;
}

/// Writes the feedback screenshot to storage and returns the file path
Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
  final output = await getTemporaryDirectory();
  final screenshotFilePath = '${output.path}/feedback.png';
  final screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}
