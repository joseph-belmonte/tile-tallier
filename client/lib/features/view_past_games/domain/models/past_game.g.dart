// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PastGameImpl _$$PastGameImplFromJson(Map<String, dynamic> json) =>
    _$PastGameImpl(
      id: json['id'] as String,
      currentPlay: Play.fromJson(json['currentPlay'] as Map<String, dynamic>),
      currentWord: Word.fromJson(json['currentWord'] as Map<String, dynamic>),
      isFavorite: json['isFavorite'] as bool,
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentPlayerIndex: (json['currentPlayerIndex'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PastGameImplToJson(_$PastGameImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currentPlay': instance.currentPlay,
      'currentWord': instance.currentWord,
      'isFavorite': instance.isFavorite,
      'players': instance.players,
      'currentPlayerIndex': instance.currentPlayerIndex,
    };
