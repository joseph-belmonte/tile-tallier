// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GamePlayer _$GamePlayerFromJson(Map<String, dynamic> json) {
  return _GamePlayer.fromJson(json);
}

/// @nodoc
mixin _$GamePlayer {
  String get name => throw _privateConstructorUsedError;
  String get id =>
      throw _privateConstructorUsedError; // Unique identifier for this GamePlayer instance
  String get gameId => throw _privateConstructorUsedError;
  String get playerId =>
      throw _privateConstructorUsedError; // Unique identifier for the Player across games
  List<Play> get plays => throw _privateConstructorUsedError;
  String get endRack => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GamePlayerCopyWith<GamePlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamePlayerCopyWith<$Res> {
  factory $GamePlayerCopyWith(
          GamePlayer value, $Res Function(GamePlayer) then) =
      _$GamePlayerCopyWithImpl<$Res, GamePlayer>;
  @useResult
  $Res call(
      {String name,
      String id,
      String gameId,
      String playerId,
      List<Play> plays,
      String endRack});
}

/// @nodoc
class _$GamePlayerCopyWithImpl<$Res, $Val extends GamePlayer>
    implements $GamePlayerCopyWith<$Res> {
  _$GamePlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? gameId = null,
    Object? playerId = null,
    Object? plays = null,
    Object? endRack = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      plays: null == plays
          ? _value.plays
          : plays // ignore: cast_nullable_to_non_nullable
              as List<Play>,
      endRack: null == endRack
          ? _value.endRack
          : endRack // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GamePlayerImplCopyWith<$Res>
    implements $GamePlayerCopyWith<$Res> {
  factory _$$GamePlayerImplCopyWith(
          _$GamePlayerImpl value, $Res Function(_$GamePlayerImpl) then) =
      __$$GamePlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String id,
      String gameId,
      String playerId,
      List<Play> plays,
      String endRack});
}

/// @nodoc
class __$$GamePlayerImplCopyWithImpl<$Res>
    extends _$GamePlayerCopyWithImpl<$Res, _$GamePlayerImpl>
    implements _$$GamePlayerImplCopyWith<$Res> {
  __$$GamePlayerImplCopyWithImpl(
      _$GamePlayerImpl _value, $Res Function(_$GamePlayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? gameId = null,
    Object? playerId = null,
    Object? plays = null,
    Object? endRack = null,
  }) {
    return _then(_$GamePlayerImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      plays: null == plays
          ? _value._plays
          : plays // ignore: cast_nullable_to_non_nullable
              as List<Play>,
      endRack: null == endRack
          ? _value.endRack
          : endRack // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GamePlayerImpl extends _GamePlayer {
  const _$GamePlayerImpl(
      {required this.name,
      required this.id,
      required this.gameId,
      required this.playerId,
      required final List<Play> plays,
      required this.endRack})
      : _plays = plays,
        super._();

  factory _$GamePlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$GamePlayerImplFromJson(json);

  @override
  final String name;
  @override
  final String id;
// Unique identifier for this GamePlayer instance
  @override
  final String gameId;
  @override
  final String playerId;
// Unique identifier for the Player across games
  final List<Play> _plays;
// Unique identifier for the Player across games
  @override
  List<Play> get plays {
    if (_plays is EqualUnmodifiableListView) return _plays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_plays);
  }

  @override
  final String endRack;

  @override
  String toString() {
    return 'GamePlayer(name: $name, id: $id, gameId: $gameId, playerId: $playerId, plays: $plays, endRack: $endRack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamePlayerImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            const DeepCollectionEquality().equals(other._plays, _plays) &&
            (identical(other.endRack, endRack) || other.endRack == endRack));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, id, gameId, playerId,
      const DeepCollectionEquality().hash(_plays), endRack);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GamePlayerImplCopyWith<_$GamePlayerImpl> get copyWith =>
      __$$GamePlayerImplCopyWithImpl<_$GamePlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GamePlayerImplToJson(
      this,
    );
  }
}

abstract class _GamePlayer extends GamePlayer {
  const factory _GamePlayer(
      {required final String name,
      required final String id,
      required final String gameId,
      required final String playerId,
      required final List<Play> plays,
      required final String endRack}) = _$GamePlayerImpl;
  const _GamePlayer._() : super._();

  factory _GamePlayer.fromJson(Map<String, dynamic> json) =
      _$GamePlayerImpl.fromJson;

  @override
  String get name;
  @override
  String get id;
  @override // Unique identifier for this GamePlayer instance
  String get gameId;
  @override
  String get playerId;
  @override // Unique identifier for the Player across games
  List<Play> get plays;
  @override
  String get endRack;
  @override
  @JsonKey(ignore: true)
  _$$GamePlayerImplCopyWith<_$GamePlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
