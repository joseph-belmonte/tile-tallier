// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
      name: json['name'] as String,
      id: json['id'] as String,
      plays: (json['plays'] as List<dynamic>?)
              ?.map((e) => Play.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      endRack: json['endRack'] as String? ?? '',
    );

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'plays': instance.plays,
      'endRack': instance.endRack,
    };
