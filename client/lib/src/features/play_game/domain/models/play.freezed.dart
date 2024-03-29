// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'play.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Play {
  List<Word> get playedWords => throw _privateConstructorUsedError;
  bool get isBingo => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayCopyWith<Play> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayCopyWith<$Res> {
  factory $PlayCopyWith(Play value, $Res Function(Play) then) =
      _$PlayCopyWithImpl<$Res, Play>;
  @useResult
  $Res call(
      {List<Word> playedWords,
      bool isBingo,
      String playerId,
      DateTime? timestamp});
}

/// @nodoc
class _$PlayCopyWithImpl<$Res, $Val extends Play>
    implements $PlayCopyWith<$Res> {
  _$PlayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playedWords = null,
    Object? isBingo = null,
    Object? playerId = null,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      playedWords: null == playedWords
          ? _value.playedWords
          : playedWords // ignore: cast_nullable_to_non_nullable
              as List<Word>,
      isBingo: null == isBingo
          ? _value.isBingo
          : isBingo // ignore: cast_nullable_to_non_nullable
              as bool,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayImplCopyWith<$Res> implements $PlayCopyWith<$Res> {
  factory _$$PlayImplCopyWith(
          _$PlayImpl value, $Res Function(_$PlayImpl) then) =
      __$$PlayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Word> playedWords,
      bool isBingo,
      String playerId,
      DateTime? timestamp});
}

/// @nodoc
class __$$PlayImplCopyWithImpl<$Res>
    extends _$PlayCopyWithImpl<$Res, _$PlayImpl>
    implements _$$PlayImplCopyWith<$Res> {
  __$$PlayImplCopyWithImpl(_$PlayImpl _value, $Res Function(_$PlayImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playedWords = null,
    Object? isBingo = null,
    Object? playerId = null,
    Object? timestamp = freezed,
  }) {
    return _then(_$PlayImpl(
      playedWords: null == playedWords
          ? _value._playedWords
          : playedWords // ignore: cast_nullable_to_non_nullable
              as List<Word>,
      isBingo: null == isBingo
          ? _value.isBingo
          : isBingo // ignore: cast_nullable_to_non_nullable
              as bool,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$PlayImpl extends _Play {
  const _$PlayImpl(
      {final List<Word> playedWords = const [],
      this.isBingo = false,
      this.playerId = '',
      this.timestamp})
      : _playedWords = playedWords,
        super._();

  final List<Word> _playedWords;
  @override
  @JsonKey()
  List<Word> get playedWords {
    if (_playedWords is EqualUnmodifiableListView) return _playedWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playedWords);
  }

  @override
  @JsonKey()
  final bool isBingo;
  @override
  @JsonKey()
  final String playerId;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'Play(playedWords: $playedWords, isBingo: $isBingo, playerId: $playerId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayImpl &&
            const DeepCollectionEquality()
                .equals(other._playedWords, _playedWords) &&
            (identical(other.isBingo, isBingo) || other.isBingo == isBingo) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_playedWords),
      isBingo,
      playerId,
      timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayImplCopyWith<_$PlayImpl> get copyWith =>
      __$$PlayImplCopyWithImpl<_$PlayImpl>(this, _$identity);
}

abstract class _Play extends Play {
  const factory _Play(
      {final List<Word> playedWords,
      final bool isBingo,
      final String playerId,
      final DateTime? timestamp}) = _$PlayImpl;
  const _Play._() : super._();

  @override
  List<Word> get playedWords;
  @override
  bool get isBingo;
  @override
  String get playerId;
  @override
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$PlayImplCopyWith<_$PlayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
