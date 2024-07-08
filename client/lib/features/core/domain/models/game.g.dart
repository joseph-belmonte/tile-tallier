// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameImpl _$$GameImplFromJson(Map<String, dynamic> json) => _$GameImpl(
      id: json['id'] as String,
      currentPlay: Play.fromJson(json['currentPlay'] as Map<String, dynamic>),
      currentWord: Word.fromJson(json['currentWord'] as Map<String, dynamic>),
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => GamePlayer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentPlayerIndex: (json['currentPlayerIndex'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$GameImplToJson(_$GameImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currentPlay': instance.currentPlay,
      'currentWord': instance.currentWord,
      'players': instance.players,
      'currentPlayerIndex': instance.currentPlayerIndex,
    };
