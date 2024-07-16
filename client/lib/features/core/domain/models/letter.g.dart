// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LetterImpl _$$LetterImplFromJson(Map<String, dynamic> json) => _$LetterImpl(
      id: json['id'] as String,
      letter: json['letter'] as String,
      scoreMultiplier: json['scoreMultiplier'] == null
          ? ScoreMultiplier.none
          : const ScoreMultiplierConverter()
              .fromJson((json['scoreMultiplier'] as num).toInt()),
    );

Map<String, dynamic> _$$LetterImplToJson(_$LetterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'letter': instance.letter,
      'scoreMultiplier':
          const ScoreMultiplierConverter().toJson(instance.scoreMultiplier),
    };
