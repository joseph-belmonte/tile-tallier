import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'letter.dart';

import 'play.dart';
import 'word.dart';

final _uuid = Uuid();

/// Accepts a name (String) and creates a new player with the given name and
/// an empty list of plays.
class Player {
  /// Creates a new Player instance.
  Player({required this.name});

  /// The name of the player.
  final String name;

  /// The unique identifier for the player.
  final String id = _uuid.v4();

  /// A list of plays made by the player.
  List<Play> plays = [];

  /// The letters remaining in the player's rack at the end of the game.
  String endRack = '';

  /// Returns the longest word played by the player.
  String get longestWord {
    if (plays.isEmpty) return '';

    var longest = plays.first.playedWords.first.word;
    var maxLength = longest.length;

    for (var play in plays) {
      for (var word in play.playedWords) {
        if (word.word.length > maxLength) {
          maxLength = word.word.length;
          longest = word.word;
        }
      }
    }
    return longest;
  }

  /// Returns the highest scoring word played by the player.
  Word get highestScoringWord {
    if (plays.isEmpty) return Word();

    var highestScoring = Word();
    var maxScore = 0;

    for (var play in plays) {
      for (var word in play.playedWords) {
        if (word.score > maxScore) {
          maxScore = word.score;
          highestScoring = word;
        }
      }
    }
    return highestScoring;
  }

  /// Returns the highest scoring turn played by the player.
  Play get highestScoringTurn {
    if (plays.isEmpty) ; // Handle empty list

    // Initialize variables to keep track of the highest-scoring turn and its score
    var highestScoring = plays.first;
    var maxScore = highestScoring.score;

    // Iterate through plays to find the highest-scoring turn
    for (var play in plays) {
      if (play.score > maxScore) {
        maxScore = play.score;
        highestScoring = play;
      }
    }
    return highestScoring;
  }

  /// Returns the shortest word played by the player.
  String get shortestWord {
    if (plays.isEmpty) return '';

    var shortest = plays.first.playedWords.first.word;
    var minLength = shortest.length;

    for (var play in plays) {
      for (var word in play.playedWords) {
        if (word.word.length < minLength) {
          minLength = word.word.length;
          shortest = word.word;
        }
      }
    }
    return shortest;
  }

  /// Returns the score for the player by summing the scores for each play.
  int get score {
    var score = 0;
    for (var play in plays) {
      score += play.score;
    }
    for (var letter in endRack.characters) {
      score -= Letter(letter).score;
    }

    return score;
  }
}
