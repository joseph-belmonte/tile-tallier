// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_advice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoredAdviceImpl _$$StoredAdviceImplFromJson(Map<String, dynamic> json) =>
    _$StoredAdviceImpl(
      playerId: json['playerId'] as String,
      adviceText: json['adviceText'] as String,
      lastFetched: DateTime.parse(json['lastFetched'] as String),
    );

Map<String, dynamic> _$$StoredAdviceImplToJson(_$StoredAdviceImpl instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'adviceText': instance.adviceText,
      'lastFetched': instance.lastFetched.toIso8601String(),
    };
