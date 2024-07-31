import 'package:freezed_annotation/freezed_annotation.dart';

part 'stored_advice.freezed.dart';
part 'stored_advice.g.dart';

@freezed

/// A class to store advice for a player.
class StoredAdvice with _$StoredAdvice {
  /// Creates a new [StoredAdvice] instance.
  const factory StoredAdvice({
    /// The Player ID for the advice.
    required String playerId,

    /// The advice to store.
    required String adviceText,

    /// Last date fetched.
    required DateTime lastFetched,
  }) = _StoredAdvice;

  /// Creates a [StoredAdvice] instance from a map.
  factory StoredAdvice.fromMap(Map<String, dynamic> map) {
    return StoredAdvice(
      playerId: map['playerId'],
      adviceText: map['adviceText'],
      lastFetched: DateTime.parse(map['lastFetched']),
    );
  }

  /// Converts a [StoredAdvice] from JSON into a map.
  factory StoredAdvice.fromJson(Map<String, dynamic> json) =>
      _$StoredAdviceFromJson(json);
}
