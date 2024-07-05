import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed

/// Represents a player across multiple games.
class Player with _$Player {
  /// Creates a new [Player] instance.
  const factory Player({
    required String name,
    required String id,
  }) = _Player;

  const Player._();

  /// Creates a new player instance from a JSON object.
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
