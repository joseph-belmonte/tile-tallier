// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stored_advice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoredAdvice _$StoredAdviceFromJson(Map<String, dynamic> json) {
  return _StoredAdvice.fromJson(json);
}

/// @nodoc
mixin _$StoredAdvice {
  /// The Player ID for the advice.
  String get playerId => throw _privateConstructorUsedError;

  /// The advice to store.
  String get adviceText => throw _privateConstructorUsedError;

  /// Last date fetched.
  DateTime get lastFetched => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoredAdviceCopyWith<StoredAdvice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoredAdviceCopyWith<$Res> {
  factory $StoredAdviceCopyWith(
          StoredAdvice value, $Res Function(StoredAdvice) then) =
      _$StoredAdviceCopyWithImpl<$Res, StoredAdvice>;
  @useResult
  $Res call({String playerId, String adviceText, DateTime lastFetched});
}

/// @nodoc
class _$StoredAdviceCopyWithImpl<$Res, $Val extends StoredAdvice>
    implements $StoredAdviceCopyWith<$Res> {
  _$StoredAdviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? adviceText = null,
    Object? lastFetched = null,
  }) {
    return _then(_value.copyWith(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      adviceText: null == adviceText
          ? _value.adviceText
          : adviceText // ignore: cast_nullable_to_non_nullable
              as String,
      lastFetched: null == lastFetched
          ? _value.lastFetched
          : lastFetched // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoredAdviceImplCopyWith<$Res>
    implements $StoredAdviceCopyWith<$Res> {
  factory _$$StoredAdviceImplCopyWith(
          _$StoredAdviceImpl value, $Res Function(_$StoredAdviceImpl) then) =
      __$$StoredAdviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String playerId, String adviceText, DateTime lastFetched});
}

/// @nodoc
class __$$StoredAdviceImplCopyWithImpl<$Res>
    extends _$StoredAdviceCopyWithImpl<$Res, _$StoredAdviceImpl>
    implements _$$StoredAdviceImplCopyWith<$Res> {
  __$$StoredAdviceImplCopyWithImpl(
      _$StoredAdviceImpl _value, $Res Function(_$StoredAdviceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? adviceText = null,
    Object? lastFetched = null,
  }) {
    return _then(_$StoredAdviceImpl(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      adviceText: null == adviceText
          ? _value.adviceText
          : adviceText // ignore: cast_nullable_to_non_nullable
              as String,
      lastFetched: null == lastFetched
          ? _value.lastFetched
          : lastFetched // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoredAdviceImpl implements _StoredAdvice {
  const _$StoredAdviceImpl(
      {required this.playerId,
      required this.adviceText,
      required this.lastFetched});

  factory _$StoredAdviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoredAdviceImplFromJson(json);

  /// The Player ID for the advice.
  @override
  final String playerId;

  /// The advice to store.
  @override
  final String adviceText;

  /// Last date fetched.
  @override
  final DateTime lastFetched;

  @override
  String toString() {
    return 'StoredAdvice(playerId: $playerId, adviceText: $adviceText, lastFetched: $lastFetched)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoredAdviceImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.adviceText, adviceText) ||
                other.adviceText == adviceText) &&
            (identical(other.lastFetched, lastFetched) ||
                other.lastFetched == lastFetched));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, playerId, adviceText, lastFetched);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoredAdviceImplCopyWith<_$StoredAdviceImpl> get copyWith =>
      __$$StoredAdviceImplCopyWithImpl<_$StoredAdviceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoredAdviceImplToJson(
      this,
    );
  }
}

abstract class _StoredAdvice implements StoredAdvice {
  const factory _StoredAdvice(
      {required final String playerId,
      required final String adviceText,
      required final DateTime lastFetched}) = _$StoredAdviceImpl;

  factory _StoredAdvice.fromJson(Map<String, dynamic> json) =
      _$StoredAdviceImpl.fromJson;

  @override

  /// The Player ID for the advice.
  String get playerId;
  @override

  /// The advice to store.
  String get adviceText;
  @override

  /// Last date fetched.
  DateTime get lastFetched;
  @override
  @JsonKey(ignore: true)
  _$$StoredAdviceImplCopyWith<_$StoredAdviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
