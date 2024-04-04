import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'letter.dart';
import 'play.dart';
import 'word.dart';

part 'player.freezed.dart';

@freezed

/// Represents a player in the game.
class Player with _$Player {
  /// Creates a new [Player] instance.
  const factory Player({
    required String name,
    required String id,
    @Default([]) List<Play> plays,
    @Default('') String endRack,
  }) = _Player;
  const Player._();

  /// The longest word by the player.
  String get longestWord {
    var longest = '';
    if (plays.isEmpty) {
      return longest;
    } else {
      for (final play in plays) {
        play.playedWords.sort((a, b) => b.word.length.compareTo(a.word.length));
        longest = play.playedWords.first.word;
      }
      return longest;
    }
  }

  /// The highest scoring word by the player.
  Word get highestScoringWord {
    var highestScoring = Word();
    if (plays.isEmpty) {
      return highestScoring;
    } else {
      for (final play in plays) {
        play.playedWords.sort((a, b) => b.score.compareTo(a.score));
        highestScoring = play.playedWords.first;
      }
      return highestScoring;
    }
  }

  /// The highest scoring play by the player.
  Play get highestScoringTurn => plays.fold(
        Play(),
        (top, play) => play.score > top.score ? play : top,
      );

  /// The total score of the player.
  int get score =>
      plays.fold(0, (total, play) => total + play.score) -
      endRack.split('').fold(0, (total, letter) => total + Letter(letter: letter).score);
}
