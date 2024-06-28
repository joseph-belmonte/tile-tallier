// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      isAuthenticated: json['isAuthenticated'] as bool? ?? false,
      email: json['email'] as String? ?? '',
      isSubscribed: json['isSubscribed'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'isAuthenticated': instance.isAuthenticated,
      'email': instance.email,
      'isSubscribed': instance.isSubscribed,
    };
