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

Play _$PlayFromJson(Map<String, dynamic> json) {
  return _Play.fromJson(json);
}

/// @nodoc
mixin _$Play {
  String get id => throw _privateConstructorUsedError;
  String get gameId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _wordsFromJson, toJson: _wordsToJson)
  List<Word> get playedWords => throw _privateConstructorUsedError;
  @BoolIntConverter()
  bool get isBingo => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayCopyWith<Play> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayCopyWith<$Res> {
  factory $PlayCopyWith(Play value, $Res Function(Play) then) =
      _$PlayCopyWithImpl<$Res, Play>;
  @useResult
  $Res call(
      {String id,
      String gameId,
      DateTime timestamp,
      @JsonKey(fromJson: _wordsFromJson, toJson: _wordsToJson)
      List<Word> playedWords,
      @BoolIntConverter() bool isBingo,
      String playerId});
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
    Object? id = null,
    Object? gameId = null,
    Object? timestamp = null,
    Object? playedWords = null,
    Object? isBingo = null,
    Object? playerId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      {String id,
      String gameId,
      DateTime timestamp,
      @JsonKey(fromJson: _wordsFromJson, toJson: _wordsToJson)
      List<Word> playedWords,
      @BoolIntConverter() bool isBingo,
      String playerId});
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
    Object? id = null,
    Object? gameId = null,
    Object? timestamp = null,
    Object? playedWords = null,
    Object? isBingo = null,
    Object? playerId = null,
  }) {
    return _then(_$PlayImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayImpl extends _Play {
  _$PlayImpl(
      {required this.id,
      required this.gameId,
      required this.timestamp,
      @JsonKey(fromJson: _wordsFromJson, toJson: _wordsToJson)
      final List<Word> playedWords = const [],
      @BoolIntConverter() this.isBingo = false,
      this.playerId = ''})
      : _playedWords = playedWords,
        super._();

  factory _$PlayImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayImplFromJson(json);

  @override
  final String id;
  @override
  final String gameId;
  @override
  final DateTime timestamp;
  final List<Word> _playedWords;
  @override
  @JsonKey(fromJson: _wordsFromJson, toJson: _wordsToJson)
  List<Word> get playedWords {
    if (_playedWords is EqualUnmodifiableListView) return _playedWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playedWords);
  }

  @override
  @JsonKey()
  @BoolIntConverter()
  final bool isBingo;
  @override
  @JsonKey()
  final String playerId;

  @override
  String toString() {
    return 'Play(id: $id, gameId: $gameId, timestamp: $timestamp, playedWords: $playedWords, isBingo: $isBingo, playerId: $playerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other._playedWords, _playedWords) &&
            (identical(other.isBingo, isBingo) || other.isBingo == isBingo) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, gameId, timestamp,
      const DeepCollectionEquality().hash(_playedWords), isBingo, playerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayImplCopyWith<_$PlayImpl> get copyWith =>
      __$$PlayImplCopyWithImpl<_$PlayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayImplToJson(
      this,
    );
  }
}

abstract class _Play extends Play {
  factory _Play(
      {required final String id,
      required final String gameId,
      required final DateTime timestamp,
      @JsonKey(fromJson: _wordsFromJson, toJson: _wordsToJson)
      final List<Word> playedWords,
      @BoolIntConverter() final bool isBingo,
      final String playerId}) = _$PlayImpl;
  _Play._() : super._();

  factory _Play.fromJson(Map<String, dynamic> json) = _$PlayImpl.fromJson;

  @override
  String get id;
  @override
  String get gameId;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(fromJson: _wordsFromJson, toJson: _wordsToJson)
  List<Word> get playedWords;
  @override
  @BoolIntConverter()
  bool get isBingo;
  @override
  String get playerId;
  @override
  @JsonKey(ignore: true)
  _$$PlayImplCopyWith<_$PlayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
