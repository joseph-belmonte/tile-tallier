// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayImpl _$$PlayImplFromJson(Map<String, dynamic> json) => _$PlayImpl(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      playedWords: (json['playedWords'] as List<dynamic>?)
              ?.map((e) => Word.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isBingo: json['isBingo'] == null
          ? false
          : const BoolIntConverter().fromJson((json['isBingo'] as num).toInt()),
      playerId: json['playerId'] as String? ?? '',
    );

Map<String, dynamic> _$$PlayImplToJson(_$PlayImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'playedWords': instance.playedWords,
      'isBingo': const BoolIntConverter().toJson(instance.isBingo),
      'playerId': instance.playerId,
    };
