// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GamePlayerImpl _$$GamePlayerImplFromJson(Map<String, dynamic> json) =>
    _$GamePlayerImpl(
      name: json['name'] as String,
      id: json['id'] as String,
      gameId: json['gameId'] as String,
      playerId: json['playerId'] as String,
      endRack: json['endRack'] as String,
      plays: (json['plays'] as List<dynamic>?)
              ?.map((e) => Play.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GamePlayerImplToJson(_$GamePlayerImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'gameId': instance.gameId,
      'playerId': instance.playerId,
      'endRack': instance.endRack,
      'plays': instance.plays,
    };
