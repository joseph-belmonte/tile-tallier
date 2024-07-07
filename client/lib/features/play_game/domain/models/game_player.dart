import 'package:freezed_annotation/freezed_annotation.dart';

import 'letter.dart';
import 'play.dart';
import 'word.dart';

part 'game_player.freezed.dart';
part 'game_player.g.dart';

@freezed

/// Represents a player object during gameplay
class GamePlayer with _$GamePlayer {
  /// Creates a new [GamePlayer] instance.
  const factory GamePlayer({
    required String name,
    required String id, // Unique identifier for this GamePlayer instance
    required String gameId,
    required String playerId, // Unique identifier for the Player across games
    required String endRack,
    @Default([]) List<Play> plays,
  }) = _GamePlayer;

  const GamePlayer._();

  /// Creates a new game player instance from a JSON object.
  factory GamePlayer.fromJson(Map<String, dynamic> json) =>
      _$GamePlayerFromJson(json);

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
    var highestScoring = Word(id: '', playedLetters: []);
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
  Play get highestScoringPlay {
    if (plays.isEmpty) {
      return Play(id: '', timestamp: DateTime.now());
    } else {
      var highestScoring = plays.first;
      for (final play in plays) {
        if (play.score > highestScoring.score) {
          highestScoring = play;
        }
      }
      return highestScoring;
    }
  }

  /// The total score of the player.
  int get score {
    final totalPlayScores = plays.fold<int>(0, (total, play) {
      final playScore = play.score;
      return total + playScore;
    });
    final endRackScore = endRack.split('').fold<int>(0, (total, letter) {
      final letterScore = Letter(
        id: '',
        letter: letter,
      ).score;
      return total + letterScore;
    });
    final score = totalPlayScores - endRackScore;
    return score;
  }

  /// Lists all plays by the player.
  List<Play> get allPlays {
    final allPlays = <Play>[];
    for (final play in plays) {
      allPlays.add(play);
    }
    return allPlays;
  }
}
