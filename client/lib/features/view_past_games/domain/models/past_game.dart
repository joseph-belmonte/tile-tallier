import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../play_game/domain/models/game.dart';
import '../../../play_game/domain/models/play.dart';
import '../../../play_game/domain/models/player.dart';
import '../../../play_game/domain/models/word.dart';

part 'past_game.freezed.dart';
part 'past_game.g.dart';

@freezed

/// Represents a past game in the storage.
class PastGame with _$PastGame {
  /// Creates a new [PastGame] instance.
  const factory PastGame({
    required String id,
    required Play currentPlay,
    required Word currentWord,
    @Default(false) bool isFavorite,
    @Default([]) List<Player> players,
    @Default(0) int currentPlayerIndex,
  }) = _PastGame;

  /// Creates a new [PastGame] instance from a [Game] instance.
  factory PastGame.fromGame(Game game) {
    return PastGame(
      id: game.id,
      currentPlay: game.currentPlay,
      currentWord: game.currentWord,
      players: game.players,
      currentPlayerIndex: game.currentPlayerIndex,
    );
  }

  /// Converts the past game to a map.
  factory PastGame.fromJson(Map<String, dynamic> json) =>
      _$PastGameFromJson(json);

  // Private constructor for computed properties and methods.
  const PastGame._();

  /// Returns the players sorted by score.
  List<Player> get sortedPlayers =>
      [...players]..sort((a, b) => b.score.compareTo(a.score));

  /// Returns the current player.
  Player get currentPlayer => players[currentPlayerIndex];

  /// Returns all the plays made by all players, sorted by timestamp.
  List<Play> get plays => players.expand((player) => player.plays).toList()
    ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

  /// Returns the highest scoring play.
  Play? get highestScoringPlay => plays.isNotEmpty
      ? plays.reduce(
          (value, element) => element.score > value.score ? element : value,
        )
      : null;

  /// Returns the highest scoring word.
  Word? get highestScoringWord =>
      plays.expand((play) => play.playedWords).reduce(
            (value, element) => element.score > value.score ? element : value,
          );

  /// Returns the longest word.
  String get longestWord =>
      plays.expand((play) => play.playedWords.map((word) => word.word)).reduce(
            (value, element) => element.length > value.length ? element : value,
          );
}
