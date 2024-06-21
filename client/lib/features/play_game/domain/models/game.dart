import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import 'play.dart';
import 'player.dart';
import 'word.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed

/// Represents a game in progress.
class Game with _$Game {
  /// Creates a new [Game] instance.
  factory Game({
    required String id,
    required Play currentPlay,
    required Word currentWord,
    @Default([]) List<Player> players,
    @Default(0) int currentPlayerIndex,
  }) = _Game;

  /// Creates a new game.
  factory Game.createNew() {
    return Game(
      id: Uuid().v4(),
      currentPlay: Play.createNew(),
      currentWord: Word.createNew(),
    );
  }

  /// Converts the game to a map.
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  // Private constructor for computed properties and methods.
  const Game._();

  /// Returns the players sorted by score.
  List<Player> get sortedPlayers => [...players]..sort((a, b) => b.score.compareTo(a.score));

  /// Returns the current player.
  Player get currentPlayer => players[currentPlayerIndex];

  /// Returns all the plays made by all players, sorted by timestamp.
  List<Play> get plays => players.expand((player) => player.plays).toList()
    ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

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
