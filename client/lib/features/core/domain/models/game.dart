import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../utils/converters.dart';
import 'game_player.dart';
import 'play.dart';
import 'word.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed

/// Represents a game in progress.
class Game with _$Game {
  /// Creates a new [Game] instance.
  factory Game({
    required String id,
    required Play? currentPlay,
    required Word? currentWord,
    @BoolIntConverter() @Default(false) bool isFavorite,
    @Default([]) List<GamePlayer> players,
    @Default(0) int currentPlayerIndex,
  }) = _Game;

  /// Creates a new game.
  factory Game.createNew() {
    final gameId = Uuid().v4();
    return Game(
      id: gameId,
      currentPlay: Play.createNew(gameId: gameId),
      currentWord: Word.createNew(),
    );
  }

  /// Accepts a JSON map and returns a new [Game] instance.
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  // Private constructor for computed properties and methods.
  const Game._();

  /// Returns the players sorted by score.
  List<GamePlayer> get sortedPlayers =>
      [...players]..sort((a, b) => b.score.compareTo(a.score));

  /// Returns the current player.
  GamePlayer get currentPlayer => players[currentPlayerIndex];

  /// Returns all the plays made by all players, sorted by timestamp.
  List<Play> get plays => players.expand((player) => player.plays).toList()
    ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

  /// Returns the highest scoring play.
  Play? get highestScoringPlay => plays.reduce(
        (value, element) => element.score > value.score ? element : value,
      );

  /// Returns the highest scoring word.
  Word get highestScoringWord =>
      plays.expand((play) => play.playedWords).reduce(
            (value, element) => element.score > value.score ? element : value,
          );

  /// Returns the longest word.
  String get longestWord =>
      plays.expand((play) => play.playedWords.map((word) => word.word)).reduce(
            (value, element) => element.length > value.length ? element : value,
          );
}
