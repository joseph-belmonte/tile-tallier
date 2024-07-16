// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayImpl _$$PlayImplFromJson(Map<String, dynamic> json) => _$PlayImpl(
      id: json['id'] as String,
      gameId: json['gameId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      playedWords: json['playedWords'] == null
          ? const []
          : _wordsFromJson(json['playedWords']),
      isBingo: json['isBingo'] == null
          ? false
          : const BoolIntConverter().fromJson((json['isBingo'] as num).toInt()),
      playerId: json['playerId'] as String? ?? '',
    );

Map<String, dynamic> _$$PlayImplToJson(_$PlayImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gameId': instance.gameId,
      'timestamp': instance.timestamp.toIso8601String(),
      'playedWords': _wordsToJson(instance.playedWords),
      'isBingo': const BoolIntConverter().toJson(instance.isBingo),
      'playerId': instance.playerId,
    };
