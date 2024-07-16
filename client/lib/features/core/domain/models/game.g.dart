// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameImpl _$$GameImplFromJson(Map<String, dynamic> json) => _$GameImpl(
      id: json['id'] as String,
      currentPlay: json['currentPlay'] == null
          ? null
          : Play.fromJson(json['currentPlay'] as Map<String, dynamic>),
      currentWord: json['currentWord'] == null
          ? null
          : Word.fromJson(json['currentWord'] as Map<String, dynamic>),
      isFavorite: json['isFavorite'] == null
          ? false
          : const BoolIntConverter()
              .fromJson((json['isFavorite'] as num).toInt()),
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
      'isFavorite': const BoolIntConverter().toJson(instance.isFavorite),
      'players': instance.players,
      'currentPlayerIndex': instance.currentPlayerIndex,
    };
