import 'package:freezed_annotation/freezed_annotation.dart';
import 'player.dart';
import 'play.dart';
import 'word.dart';

part 'game.freezed.dart';

@freezed

/// Represents a game in progress.
class Game with _$Game {
  /// Creates a new [Game] instance.
  const factory Game({
    required String id,
    @Default([]) List<Player> players,
    @Default(0) int currentPlayerIndex,
    @Default(Play()) Play currentPlay,
    @Default(Word()) Word currentWord,
  }) = _Game;

  // Private constructor for computed properties and methods.
  const Game._();

  /// Returns the players sorted by score.
  List<Player> get sortedPlayers => [...players]..sort((a, b) => b.score.compareTo(a.score));

  /// Returns the current player.
  Player get currentPlayer => players[currentPlayerIndex];

  /// Returns all the plays made by all players.
  List<Play> get plays => players.expand((player) => player.plays).toList();

  /// Returns the highest scoring play.
  Play? get highestScoringPlay =>
      plays.reduce((value, element) => element.score > value.score ? element : value);

  /// Returns the highest scoring word.
  Word get highestScoringWord => plays
      .expand((play) => play.playedWords)
      .reduce((value, element) => element.score > value.score ? element : value);

  /// Returns the longest word.
  String get longestWord => plays
      .expand((play) => play.playedWords.map((word) => word.word))
      .reduce((value, element) => element.length > value.length ? element : value);
}
