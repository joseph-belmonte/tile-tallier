// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthStateImpl _$$AuthStateImplFromJson(Map<String, dynamic> json) =>
    _$AuthStateImpl(
      isAuthenticated: json['isAuthenticated'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? false,
      user: json['user'] == null
          ? const User()
          : User.fromJson(json['user'] as Map<String, dynamic>),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$AuthStateImplToJson(_$AuthStateImpl instance) =>
    <String, dynamic>{
      'isAuthenticated': instance.isAuthenticated,
      'isLoading': instance.isLoading,
      'user': instance.user,
      'error': instance.error,
    };
